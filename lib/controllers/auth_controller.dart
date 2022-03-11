import 'package:flutter/cupertino.dart';
import 'package:sportivo/enum/auth_mode.dart';
import 'package:sportivo/repositories/auth.dart';

class AuthController with ChangeNotifier {
  AuthMode _authMode = AuthMode.Login;
  Auth _auth = Auth();

  void switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      _authMode = AuthMode.Signup;
    } else {
      _authMode = AuthMode.Login;
    }
    notifyListeners();
  }

  Future<void> login(String email, String password, bool isLogin) async {
    if (isLogin) {
      await _auth.signIn(email, password);
      notifyListeners();
    } else {
      await _auth.signUp(email, password);
      notifyListeners();
    }
  }

  void logout() {
    _auth.logout();
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

  get authMode => _authMode;
}
