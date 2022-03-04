import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportivo/controllers/theme_controller.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({Key? key}) : super(key: key);

  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Tema'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text('Modo Claro'),
              trailing: Radio(
                value: 0,
                groupValue: themeProvider.selectedTheme,
                onChanged: (value) {
                  themeProvider.changeTheme(value as int);
                },
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text('Modo Escuro'),
              trailing: Radio(
                value: 1,
                groupValue: themeProvider.selectedTheme,
                onChanged: (value) {
                  themeProvider.changeTheme(value as int);
                },
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text('Padrão do Sistema'),
              trailing: Radio(
                value: 2,
                groupValue: themeProvider.selectedTheme,
                onChanged: (value) {
                  themeProvider.changeTheme(value as int);
                },
              ),
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}
