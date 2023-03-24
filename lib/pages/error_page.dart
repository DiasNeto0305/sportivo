import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String errorMessage;

  const ErrorPage({Key? key, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Erro'),
      ),
      body: Center(
        child: Text(
          errorMessage,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
