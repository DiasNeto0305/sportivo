import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sportivo/controllers/auth_controller.dart';
import 'package:sportivo/exceptions/auth_exception.dart';
import 'package:sportivo/theme/colors.dart';
import 'package:sportivo/utils/constants.dart';
import 'package:sportivo/utils/utils.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _passwordSignUpController = TextEditingController();

  final Map<String, String> _authDataSignUp = {
    'name': '',
    'email': '',
    'password': ''
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthController>(context);

    Widget _title() {
      return Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Text(
            'Cadastrar',
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

    void _signUp() async {
      final isValid = _formKey.currentState?.validate() ?? false;
      if (!isValid) {
        return;
      }
      _formKey.currentState?.save();
      try {
        await provider.signUp(
          _authDataSignUp['name'] ?? '',
          _authDataSignUp['email'] ?? '',
          _authDataSignUp['password'] ?? '',
        );
        Navigator.of(context).pushNamed('/loading');
      } on AuthException catch (error) {
        showSnackbar(context: context, msg: error.toString(), color: Colors.red[900]);
      } catch (error) {
        print(error);
        showSnackbar(context: context, msg: 'Ocorreu um erro inesperado', color: Colors.red[900]);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        foregroundColor: SportivoColors.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _title(),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(16),
                        labelText: 'Nome de Usuário',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (name) => validateName(name),
                      onSaved: (name) => _authDataSignUp['name'] = name ?? '',
                    ),
                  ),
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
                      onSaved: (email) =>
                          _authDataSignUp['email'] = email ?? '',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      obscureText: true,
                      controller: _passwordSignUpController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(16),
                        labelText: 'Senha',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (_password) => validatePassword(_password),
                      onSaved: (password) =>
                          _authDataSignUp['password'] = password ?? '',
                    ),
                  ),
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
                        if (_passwordSignUpController.text != password) {
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
                        backgroundColor: SportivoColors.primary,
                        foregroundColor: SportivoColors.lightBackground,
                        minimumSize: Size(double.infinity, 48),
                      ),
                      onPressed: _signUp,
                      icon: FaIcon(
                        FontAwesomeIcons.rightToBracket,
                      ),
                      label: Text(
                        'Cadastrar',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
