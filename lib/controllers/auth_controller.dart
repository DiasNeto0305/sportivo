import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:sportivo/repositories/auth.dart';

class AuthController with ChangeNotifier {
  Auth _auth = Auth();

  Future<void> signIn(String email, String password) async {
    await _auth.signIn(email, password);
    notifyListeners();
  }

  Future<void> signUp(String name, String email, String password) async {
    await _auth.signUp(name, email, password);
    notifyListeners();
  }

  Future<void> loginWithGoogle() async {
    await _auth.loginWithGoogle();
    notifyListeners();
  }

  void logout() async {
    await _auth.logout();
    notifyListeners();
    print(isAuth);
  }

  bool get isAuth {
    return _auth.isAuth;
  }

  String? get token {
    return _auth.token;
  }

  String? get userId {
    return _auth.userId;
  }

  User? get loggedUser {
    return _auth.loggedUser;
  }
}
