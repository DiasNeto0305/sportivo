import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportivo/controllers/auth_controller.dart';
import 'package:sportivo/controllers/place_controller.dart';
import 'package:sportivo/pages/login_page.dart';
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
    AuthController auth = Provider.of<AuthController>(context);
    if (auth.isAuth) {
      _loadPlacesAndNavigate(BottomNavigation());
    } else {
      _navigateTo(LoginPage());
    }
  }

  void _loadPlacesAndNavigate(Widget destination) {
    PlaceController placeController =
        Provider.of<PlaceController>(context, listen: false);
    placeController.loadPlaces().then((_) {
      _navigateTo(destination);
    }).catchError((error) {
      print(error);
      Navigator.of(context).pushNamed('/error');
    });
  }

  void _navigateTo(Widget destination) {
    Future.delayed(Duration(seconds: 1), () {
      Navigator.of(context).push(
        PageRouteBuilder(
            pageBuilder: ((context, animation, secondaryAnimation) {
              return destination;
            }),
            transitionDuration: Duration(seconds: 1),
            transitionsBuilder: (context, animation, _, child) =>
                FadeTransition(
                  opacity: animation,
                  child: child,
                )),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
