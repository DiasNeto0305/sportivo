import 'package:flutter/material.dart';

void showSnackbar({required BuildContext context, required String msg, required Color? color}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
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

String? validateName(String? name) {
  if (name == null || name.trim().isEmpty) {
    return 'Nome é obrigatório.';
  }
  return null;
}

String? validateEmail(String? email) {
  if (email == null || email.trim().isEmpty) {
    return 'Email é obrigatório.';
  } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
    return 'Por favor, informe um email válido.';
  }
  return null;
}

String? validatePassword(String? password) {
  if (password == null || password.trim().isEmpty) {
    return 'Senha é obrigatória.';
  } else if (password.length < 6) {
    return 'Senha deve ter pelo menos 6 caracteres.';
  }
  return null;
}
