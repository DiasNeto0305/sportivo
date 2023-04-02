import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sportivo/controllers/auth_controller.dart';
import 'package:sportivo/exceptions/auth_exception.dart';
import 'package:sportivo/utils/constants.dart';

import '../enum/auth_mode.dart';
import '../utils/utils.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Map<String, String> _authData = {'email': '', 'password': ''};

  @override
  Widget build(BuildContext context) {
    bool _isLogin() =>
        Provider.of<AuthController>(context).authMode == AuthMode.Login;

    final height = MediaQuery.of(context).viewPadding.top;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _logo(height),
            _authForm(context, _isLogin()),
          ],
        ),
      ),
    );
  }

  Widget _logo(double height) {
    return Column(
      children: [
        SizedBox(
          height: height + 50,
        ),
        Image.asset(Constants.LOGO),
        Text(
          Constants.APP_NAME,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          Constants.APP_SLOGAN,
          style: TextStyle(fontSize: 12),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget _authForm(BuildContext context, bool _isLogin) {
    final provider = Provider.of<AuthController>(context);

    void _submit() async {
      final isValid = _formKey.currentState?.validate() ?? false;
      if (!isValid) {
        return;
      }
      _formKey.currentState?.save();
      try {
        await provider.login(
          _authData['email'] ?? '',
          _authData['password'] ?? '',
          _isLogin,
        );
        Navigator.of(context).pushNamed('/loading');
      } on AuthException catch (error) {
        showErrorSnackbar(context: context, msg: error.toString());
      } catch (error) {
        print(error);
        showErrorSnackbar(context: context, msg: 'Ocorreu um erro inesperado');
      }
    }

    Future signIn() async {
      try {
        await provider.loginWithGoogle();
        Navigator.of(context).pushNamed('/loading');
      } catch (error) {
        print(error);
        showErrorSnackbar(context: context, msg: 'Ocorreu um erro inesperado');
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(16),
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              textInputAction: TextInputAction.next,
              validator: (_email) => validateEmail(_email),
              onSaved: (email) => _authData['email'] = email ?? '',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(16),
                labelText: 'Senha',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              textInputAction: TextInputAction.next,
              validator: (_password) => validatePassword(_password),
              onSaved: (password) => _authData['password'] = password ?? '',
            ),
          ),
          if (!_isLogin)
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                    labelText: 'Confirmar Senha',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
                textInputAction: TextInputAction.next,
                validator: (_password) {
                  final password = _password ?? '';
                  if (_passwordController.text != password) {
                    return 'Senhas informadas não conferem';
                  }
                  return null;
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                minimumSize: Size(double.infinity, 48),
              ),
              onPressed: _submit,
              icon: FaIcon(
                FontAwesomeIcons.rightToBracket,
              ),
              label: Text(
                _isLogin ? 'Entrar' : 'Registrar',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white70,
                foregroundColor: Colors.black,
                minimumSize: Size(double.infinity, 48),
              ),
              onPressed: signIn,
              icon: FaIcon(
                FontAwesomeIcons.google,
              ),
              label: Text("Entrar com Google"),
            ),
          ),
          TextButton(
            onPressed: provider.switchAuthMode,
            child: Text(
              _isLogin ? 'Deseja registrar?' : 'Já possui cadastro?',
            ),
          )
        ],
      ),
    );
  }
}
