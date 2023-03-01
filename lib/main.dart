import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:sportivo/controllers/auth_controller.dart';
import 'package:sportivo/controllers/place_controller.dart';
import 'package:sportivo/controllers/theme_controller.dart';
import 'package:sportivo/pages/bottom_navigation.dart';
import 'package:sportivo/pages/config_page.dart';
import 'package:sportivo/pages/loading_page.dart';
import 'package:sportivo/pages/places_form.dart';
import 'package:sportivo/pages/theme_page.dart';
import 'package:sportivo/theme/darkTheme.dart';
import 'package:sportivo/theme/lightTheme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  static const themeMode = [ThemeMode.light, ThemeMode.dark, ThemeMode.system];
  final routes = {
    '/place-form': (ctx) => PlacesForm(),
    '/theme': (ctx) => ThemePage(),
    '/default': (ctx) => BottomNavigation(),
    '/loading': (ctx) => LoadingPage(),
    '/config': (ctx) => ConfigPage()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _buildLayout(),
    );
  }

  Widget _buildLayout() {
    return LayoutBuilder(builder: (context, constraints) {
      ScreenUtil.init(constraints,
          designSize: Size(411, 866), context: context);
      return _buildProvider();
    });
  }

  Widget _buildProvider() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthController(),
        ),
        ChangeNotifierProxyProvider<AuthController, PlaceController>(
          create: (_) => PlaceController('', '', []),
          update: (ctx, auth, previous) {
            return PlaceController(
              auth.token ?? '',
              auth.userId ?? '',
              previous?.places ?? [],
            );
          },
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeController(),
        ),
      ],
      builder: (context, _) => _buildApp(context),
    );
  }

  Widget _buildApp(BuildContext context) {
    final selectedIndex = Provider.of<ThemeController>(context).selectedTheme;

    return MaterialApp(
      title: 'Sportivo',
      themeMode: themeMode[selectedIndex],
      theme: LightTheme.data,
      darkTheme: DarkTheme.data,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _initialization,
        builder: (context, app) {
          return LoadingPage();
        },
      ),
      routes: routes,
    );
  }
}
