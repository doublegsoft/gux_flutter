/*
** ──────────────────────────────────────────────────
** ─██████████████─██████──██████─████████──████████─
** ─██░░░░░░░░░░██─██░░██──██░░██─██░░░░██──██░░░░██─
** ─██░░██████████─██░░██──██░░██─████░░██──██░░████─
** ─██░░██─────────██░░██──██░░██───██░░░░██░░░░██───
** ─██░░██─────────██░░██──██░░██───████░░░░░░████───
** ─██░░██──██████─██░░██──██░░██─────██░░░░░░██─────
** ─██░░██──██░░██─██░░██──██░░██───████░░░░░░████───
** ─██░░██──██░░██─██░░██──██░░██───██░░░░██░░░░██───
** ─██░░██████░░██─██░░██████░░██─████░░██──██░░████─
** ─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░██──██░░░░██─
** ─██████████████─██████████████─████████──████████─
** ──────────────────────────────────────────────────
*/
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '/welcome.dart';
import 'gux/screen/app_screen.dart';
import 'gux/screen/page_screen.dart';
import 'gux/screen/widget_screen.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(GUX()));
}

class GUX extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: WelcomeScreen(),
      routes: {
        '/': (conetxt) => WelcomePage(),
        '/main': (context) => MainPage(),
      },
    );
  }
}

class MainPage extends StatelessWidget {

  final _pageController = PageController(initialPage: 0);

  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        extendBodyBehindAppBar: false, // Extends the body behind the AppBar
        appBar: null,
        // bottomNavigationBar:
        body: PersistentTabView(context,
          controller: _controller,
          items: <PersistentBottomNavBarItem>[
            PersistentBottomNavBarItem(
              icon: Icon(Icons.home),
              title: "Home",
              activeColorPrimary: Colors.blue,
              inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(Icons.search),
              title: ("Search"),
              activeColorPrimary: Colors.blue,
              inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(Icons.person),
              title: ("Profile"),
              activeColorPrimary: Colors.blue,
              inactiveColorPrimary: Colors.grey,
            ),
          ],
          backgroundColor: Colors.white,
          // hideNavigationBarWhenKeyboardShows: true,
          // popAllScreensOnTapOfSelectedTab: true,
          navBarStyle: NavBarStyle.style13,
          screens: [WidgetScreen(), PageScreen(), AppScreen()],
        ),
      ),
    );
  }
}
