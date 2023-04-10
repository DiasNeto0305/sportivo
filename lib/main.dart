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
import 'package:sportivo/pages/password_recovery_page.dart';
import 'package:sportivo/pages/places_form.dart';
import 'package:sportivo/pages/signup_page.dart';
import 'package:sportivo/pages/theme_page.dart';
import 'package:sportivo/theme/darkTheme.dart';
import 'package:sportivo/theme/lightTheme.dart';
import 'package:sportivo/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const themeMode = [ThemeMode.light, ThemeMode.dark, ThemeMode.system];
  final routes = {
    AppRoutes.PLACE_FORM: (ctx) => PlacesForm(),
    AppRoutes.THEME: (ctx) => ThemePage(),
    AppRoutes.DEFAULT: (ctx) => BottomNavigation(),
    AppRoutes.LOADING: (ctx) => LoadingPage(),
    AppRoutes.CONFIG: (ctx) => ConfigPage(),
    AppRoutes.SIGNUP: (ctx) => SignupPage(),
    AppRoutes.PASSWORD_RECOVERY: (ctx) => PasswordRecoveryPage(),
    '/error': (ctx) => ErrorPage(
          errorMessage: '',
        )
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.APP_NAME,
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
          ScreenUtil.init(context, designSize: Size(411, 866));
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
      debugShowCheckedModeBanner: false,
    );
  }
}
