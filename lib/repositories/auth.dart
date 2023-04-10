import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sportivo/exceptions/auth_exception.dart';

class Auth {
  String? _token;
  String? _email;
  String? _userId;
  DateTime? _expiryDate;
  User? _loggedUser;
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

  User? get loggedUser {
    return isAuth ? _loggedUser : null;
  }

  DateTime? get expiryDate {
    return isAuth ? _expiryDate : null;
  }

  Future<void> signUp(String name, String email, String password) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      await user?.updateDisplayName(name);

      print(user);
    } on FirebaseAuthException catch (error) {
      throw AuthException(error.code);
    } catch (error) {
      AuthException('Erro inesperado');
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;

      _token = await user?.getIdToken();
      _email = user?.email;
      _userId = user?.uid;
      _loggedUser = user;

      _expiryDate = DateTime.now().add(
        Duration(seconds: 3600),
      );
    } on FirebaseAuthException catch (error) {
      throw AuthException(error.code);
    } catch (error) {
      AuthException('Erro inesperado');
    }
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
    try {
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
        _loggedUser = user;
        _googleLoginFlag = true;
        _expiryDate = DateTime.now().add(
          Duration(seconds: 3600),
        );
      }
    } catch (error) {
      throw AuthException('Erro inesperado');
    }
  }
}
