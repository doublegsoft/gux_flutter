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

import '/welcome.dart';
import 'gux/screen/app_screen.dart';
import 'gux/screen/page_screen.dart';
import 'gux/screen/widget_screen.dart';

import 'package:gux/styles.dart' as styles;

void main() {
  initializeDateFormatting().then((_) => runApp(GUX()));
}

class GUX extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => GUXState();

}

class GUXState extends State<GUX> with WidgetsBindingObserver {

  @override
  Widget build(BuildContext context) {
    styles.init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: WelcomeScreen(),
      routes: {
        '/': (conetxt) => WelcomePage(),
        '/main': (context) => MainPage(),
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
      // App is resumed (foreground)
        print('App resumed');
        break;
      case AppLifecycleState.inactive:
      // App is inactive (e.g., when a phone call is received)
        print('App inactive');
        break;
      case AppLifecycleState.paused:
      // App is paused (background)
        print('App paused');
        break;
      case AppLifecycleState.detached:
      // App is detached (e.g., when the system is shutting down the app)
        print('App detached');
        break;
      case AppLifecycleState.hidden:
        // TODO: Handle this case.
    }
  }
}

class MainPage extends StatefulWidget {

  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {

  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        extendBodyBehindAppBar: false, // Extends the body behind the AppBar
        appBar: null,
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
          indicatorColor: Colors.amber,
          selectedIndex: _currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: '组件',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.find_in_page),
              icon: Icon(Icons.find_in_page_outlined),
              label: '页面',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.touch_app),
              icon: Icon(Icons.touch_app_outlined),
              label: '应用',
            ),
          ],
        ),
        body: [WidgetScreen(), PageScreen(), AppScreen()][_currentPageIndex],
      ),
    );
  }
}
