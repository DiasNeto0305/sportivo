import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportivo/components/bottom_navigation.dart';
import 'package:sportivo/models/place_list.dart';
import 'package:sportivo/pages/events_page.dart';
import 'package:sportivo/pages/home_page.dart';
import 'package:sportivo/pages/profile_page.dart';
import 'package:sportivo/pages/search_page.dart';


class DefaultPage extends StatefulWidget {
  const DefaultPage({Key? key}) : super(key: key);

  @override
  _DefaultPageState createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  int _currentIndex = 0;

  onTapped(int pageIndex) {
    setState(() {
      _currentIndex = pageIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<PlaceList>(context, listen: false).loadPlaces();
  }

  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    EventsPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigation(onTap: onTapped),
    );
  }
}
