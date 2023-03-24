import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:sportivo/exceptions/auth_exception.dart';

class Auth {
  String? _token;
  String? _email;
  String? _userId;
  DateTime? _expiryDate;
  bool _googleLoginFlag = false;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  bool get isAuth {
    final isValid = _expiryDate?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValid;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  String? get userId {
    return isAuth ? _userId : null;
  }

  DateTime? get expiryDate {
    return isAuth ? _expiryDate : null;
  }

  Future<void> _authenticate(
      String email, String password, String urlFragment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=AIzaSyAiAnpVxgHIeY-nw8Bv01i4Bs2Nm8FBUW0';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(
        {'email': email, 'password': password, 'returnSecureToken': true},
      ),
    );

    final body = jsonDecode(response.body);

    if (body['error'] != null) {
      throw AuthException(body['error']['message']);
    } else {
      _token = body['idToken'];
      _email = body['email'];
      _userId = body['localId'];

      _expiryDate = DateTime.now().add(
        Duration(seconds: int.parse(body['expiresIn'])),
      );
    }
  }

  Future<void> signUp(String email, String password) async {
    await _authenticate(email, password, 'signUp');
  }

  Future<void> signIn(String email, String password) async {
    await _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> logout() async {
    _token = null;
    _email = null;
    _userId = null;
    _expiryDate = null;
    if (_googleLoginFlag) await _googleSignIn.disconnect();
    _googleLoginFlag = false;
  }

  Future<void> loginWithGoogle() async {
    final googleSignInAccount = await _googleSignIn.signIn();

    if (googleSignInAccount != null) {
      // Obter as credenciais de autenticação do Google
      final GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      // Crie um provedor de autenticação do Google
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Use as credenciais para autenticar com o Firebase
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final user = userCredential.user;
      print(userCredential.user);

      _token = await user?.getIdToken();
      _email = user?.email;
      _userId = user?.uid;
      _googleLoginFlag = true;
      _expiryDate = DateTime.now().add(
        Duration(seconds: 3600),
      );
    }
  }
}
