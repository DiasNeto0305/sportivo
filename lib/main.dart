import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:sportivo/controllers/auth_controller.dart';
import 'package:sportivo/controllers/place_controller.dart';
import 'package:sportivo/controllers/theme_controller.dart';
import 'package:sportivo/pages/bottom_navigation.dart';
import 'package:sportivo/pages/config_page.dart';
import 'package:sportivo/pages/error_page.dart';
import 'package:sportivo/pages/loading_page.dart';
import 'package:sportivo/pages/places_form.dart';
import 'package:sportivo/pages/theme_page.dart';
import 'package:sportivo/theme/darkTheme.dart';
import 'package:sportivo/theme/lightTheme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const themeMode = [ThemeMode.light, ThemeMode.dark, ThemeMode.system];
  final routes = {
    '/place-form': (ctx) => PlacesForm(),
    '/theme': (ctx) => ThemePage(),
    '/default': (ctx) => BottomNavigation(),
    '/loading': (ctx) => LoadingPage(),
    '/config': (ctx) => ConfigPage(),
    '/error': (ctx) => ErrorPage(
          errorMessage: '',
        )
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sportivo',
      home: MultiProvider(
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
        child: LayoutBuilder(builder: (context, constraints) {
          ScreenUtil.init(constraints,
              designSize: Size(411, 866), context: context);
          return MaterialApp(
            themeMode:
                themeMode[Provider.of<ThemeController>(context).selectedTheme],
            theme: LightTheme.data,
            darkTheme: DarkTheme.data,
            debugShowCheckedModeBanner: false,
            home: LoadingPage(),
            routes: routes,
          );
        }),
      ),
    );
  }
}


      // home: StreamBuilder(
      //   stream: _initialization.asStream(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(
      //         child: Text("Firebase sendo iniciado"),
      //       );
      //     } else if (snapshot.connectionState == ConnectionState.done) {
      //       return LoadingPage();
      //     } else {
      //       return Center(child: Text('Erro ao inicializar o Firebase.'));
      //     }
      //   },
      // ),
