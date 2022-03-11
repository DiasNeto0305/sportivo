import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sportivo/controllers/auth_controller.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 4),
                leading: FaIcon(
                  FontAwesomeIcons.paintBrush,
                  size: 16,
                ),
                title: Text(
                  'Tema',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/theme');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 4),
                leading: FaIcon(
                  FontAwesomeIcons.signOutAlt,
                  color: Colors.red[900],
                  size: 16,
                ),
                title: Text(
                  'Sair',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  Provider.of<AuthController>(context, listen: false).logout();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
