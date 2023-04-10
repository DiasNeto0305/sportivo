import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sportivo/theme/colors.dart';
import 'package:sportivo/utils/utils.dart';

class PasswordRecoveryPage extends StatefulWidget {
  PasswordRecoveryPage({Key? key}) : super(key: key);

  @override
  State<PasswordRecoveryPage> createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '';

  @override
  Widget build(BuildContext context) {
    void _sendEmail() async {
      final isValid = _formKey.currentState?.validate() ?? false;
      if (!isValid) {
        return;
      }
      _formKey.currentState?.save();
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
        showSnackbar(
          context: context,
          msg: 'Um e-mail de recuperação de senha foi enviado para $_email.',
          color: Colors.green[900],
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          showSnackbar(
            context: context,
            msg: 'Não há usuário cadastrado com esse email.',
            color: Colors.red[900],
          );
        } else {
          showSnackbar(
            context: context,
            msg: 'Erro ao enviar e-mail de recuperação de senha',
            color: Colors.red[900],
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        foregroundColor: SportivoColors.primary,
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  'Digite o email de recuperação de senha:',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (email) => validateEmail(email),
                onSaved: (email) => _email = email ?? '',
              ),
              SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: SportivoColors.primary,
                  foregroundColor: SportivoColors.lightBackground,
                  minimumSize: Size(double.infinity, 48),
                ),
                onPressed: () => _sendEmail(),
                child: Text('Enviar Email'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
