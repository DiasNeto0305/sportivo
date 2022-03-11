import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sportivo/controllers/auth_controller.dart';
import 'package:sportivo/controllers/place_controller.dart';
import 'package:sportivo/pages/auth_page.dart';
import 'package:sportivo/pages/bottom_navigation.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AuthController auth = Provider.of(context);
    if (auth.isAuth) {
      Provider.of<PlaceController>(context, listen: false)
          .loadPlaces()
          .then((value) {
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).push(
            PageRouteBuilder(
                pageBuilder: ((context, animation, secondaryAnimation) {
                  return BottomNavigation();
                }),
                transitionDuration: Duration(seconds: 2),
                transitionsBuilder: (context, animation, _, child) =>
                    FadeTransition(
                      opacity: animation,
                      child: child,
                    )),
          );
        });
      }).catchError((error) {
        print('Eu entrei');
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).push(
            PageRouteBuilder(
                pageBuilder: ((context, animation, secondaryAnimation) {
                  return BottomNavigation();
                }),
                transitionDuration: Duration(seconds: 2),
                transitionsBuilder: (context, animation, _, child) =>
                    FadeTransition(
                      opacity: animation,
                      child: child,
                    )),
          );
        });
      });
    } else {
      Future.delayed(Duration(seconds: 1), () {
        Navigator.of(context).push(
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) {
                return AuthPage();
              }),
              transitionDuration: Duration(seconds: 2),
              transitionsBuilder: (context, animation, _, child) =>
                  FadeTransition(
                    opacity: animation,
                    child: child,
                  )),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/animation/lottie.json',
        ),
      ),
    );
  }
}
