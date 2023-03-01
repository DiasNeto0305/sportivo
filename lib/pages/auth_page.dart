import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sportivo/controllers/auth_controller.dart';
import 'package:sportivo/exceptions/auth_exception.dart';

import '../enum/auth_mode.dart';

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

  Widget _authForm(BuildContext context, bool _isLogin) {
    final provider = Provider.of<AuthController>(context);

    void _showErrorSnackbar(String msg) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red[900],
          content: Text(
            msg,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          action: SnackBarAction(
            label: 'Fechar',
            textColor: Colors.black,
            onPressed: () {},
          ),
        ),
      );
    }

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
        _showErrorSnackbar(error.toString());
      } catch (error) {
        _showErrorSnackbar('Ocorreu um erro inesperado');
      }
    }

    String? _validateEmail(String? email) {
      if (email == null || email.trim().isEmpty) {
        return 'Email é obrigatório.';
      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
        return 'Por favor, informe um email válido.';
      }
      return null;
    }

    String? _validatePassword(String? password) {
      if (password == null || password.trim().isEmpty) {
        return 'Senha é obrigatória.';
      } else if (password.length < 6) {
        return 'Senha deve ter pelo menos 6 caracteres.';
      }
      return null;
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              textInputAction: TextInputAction.next,
              validator: (_email) => _validateEmail(_email),
              onSaved: (email) => _authData['email'] = email ?? '',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              textInputAction: TextInputAction.next,
              validator: (_password) => _validatePassword(_password),
              onSaved: (password) => _authData['password'] = password ?? '',
            ),
          ),
          if (!_isLogin)
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
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
            child: Container(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: FaIcon(FontAwesomeIcons.signInAlt),
                label: Text(
                  _isLogin ? 'Entrar' : 'Registrar',
                ),
                onPressed: _submit,
              ),
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

  Widget _logo(double height) {
    return Column(
      children: [
        SizedBox(
          height: height + 100,
        ),
        Image.asset('assets/img/Logo.png'),
        Text(
          'SPORTIVO',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Seu aplicativo de práticas esportivas',
          style: TextStyle(fontSize: 12),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
