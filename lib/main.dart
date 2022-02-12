import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sportivo/models/place_list.dart';
import 'package:sportivo/pages/default_page.dart';
import 'package:sportivo/pages/loading_page.dart';
import 'package:sportivo/pages/places_form.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      ScreenUtil.init(constraints, designSize: Size(411, 866));
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => PlaceList(),
          )
        ],
        child: MaterialApp(
          title: 'Sportivo',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
          ),
          debugShowCheckedModeBanner: false,
          home: FutureBuilder(
            future: _initialization,
            builder: (context, app) {
              if (app.connectionState == ConnectionState.done) {
                return const DefaultPage();
              }
              return const LoadingPage();
            },
          ),
          routes: {'/place-form': (ctx) => PlacesForm()},
        ),
      );
    });
  }
}
