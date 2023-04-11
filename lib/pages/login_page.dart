import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sportivo/controllers/auth_controller.dart';
import 'package:sportivo/exceptions/auth_exception.dart';
import 'package:sportivo/theme/colors.dart';
import 'package:sportivo/utils/constants.dart';

import '../utils/utils.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _authData = {'email': '', 'password': ''};

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).viewPadding.top;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _logo(height),
              _authForm(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logo(double height) {
    return Column(
      children: [
        SizedBox(
          height: height,
        ),
        Image.asset(Constants.LOGO),
        Text(
          Constants.APP_NAME,
          style: TextStyle(
            fontFamily: 'Alkatra',
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          Constants.APP_SLOGAN,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _authForm(BuildContext context) {
    final provider = Provider.of<AuthController>(context);

    void _login() async {
      final isValid = _formKey.currentState?.validate() ?? false;
      if (!isValid) {
        return;
      }
      _formKey.currentState?.save();
      try {
        await provider.signIn(
          _authData['email'] ?? '',
          _authData['password'] ?? '',
        );
        Navigator.of(context).pushNamed('/loading');
      } on AuthException catch (error) {
        showSnackbar(
            context: context, msg: error.toString(), color: Colors.red[900]);
      } catch (error) {
        print(error);
        showSnackbar(
            context: context,
            msg: 'Ocorreu um erro inesperado',
            color: Colors.red[900]);
      }
    }

    Future _loginWithGoogle() async {
      try {
        await provider.loginWithGoogle();
        Navigator.of(context).pushNamed('/loading');
      } catch (error) {
        print(error);
        showSnackbar(
            context: context,
            msg: 'Ocorreu um erro inesperado',
            color: Colors.red[900]);
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
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
                labelText: 'Senha',
              ),
              textInputAction: TextInputAction.next,
              validator: (_password) => validatePassword(_password),
              onSaved: (password) => _authData['password'] = password ?? '',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: SportivoColors.primary,
                foregroundColor: SportivoColors.lightBackground,
                minimumSize: Size(double.infinity, 48),
              ),
              onPressed: _login,
              icon: FaIcon(
                FontAwesomeIcons.rightToBracket,
              ),
              label: Text(
                'Entrar',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: SportivoColors.primaryDark,
                foregroundColor: SportivoColors.lightBackground,
                minimumSize: Size(double.infinity, 48),
              ),
              onPressed: _loginWithGoogle,
              icon: FaIcon(
                FontAwesomeIcons.google,
              ),
              label: Text("Entrar com Google"),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PASSWORD_RECOVERY);
            },
            child: Text(
              'Esqueceu sua senha?',
              style: TextStyle(color: SportivoColors.primaryLight),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.SIGNUP);
            },
            child: Text(
              'Ainda não possui conta? Cadastre-se',
              style: TextStyle(color: SportivoColors.primaryLight),
            ),
          ),
        ],
      ),
    );
  }
}
