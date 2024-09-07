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
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

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

  final NotchBottomBarController _controller = NotchBottomBarController(index: 0);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        extendBodyBehindAppBar: false, // Extends the body behind the AppBar
        appBar: null,
        // AppBar(
        //   title: Text('GUX'),
        //   backgroundColor: Colors.transparent, // Makes the AppBar transparent
        //   elevation: 0, // Removes shadow/elevation
        //   automaticallyImplyLeading: false,
        // ),
        bottomNavigationBar: AnimatedNotchBottomBar(
          /// Provide NotchBottomBarController
          notchBottomBarController: _controller,
          color: Colors.lightBlueAccent.withOpacity(0.5),
          showLabel: true,
          textOverflow: TextOverflow.visible,
          maxLine: 1,
          shadowElevation: 5,
          kBottomRadius: 28.0,

          notchColor: Colors.lightBlueAccent.withOpacity(0.5),

          /// restart app if you change removeMargins
          removeMargins: false,
          bottomBarWidth: 500,
          showShadow: false,
          durationInMilliSeconds: 300,
          itemLabelStyle: const TextStyle(fontSize: 10),
          elevation: 1,
          bottomBarItems: const [
            BottomBarItem(
              inActiveItem: ImageIcon(
                AssetImage('asset/image/widget.png'),
                size: 24.0,
                color: Colors.blueAccent,
              ),
              activeItem: ImageIcon(
                AssetImage('asset/image/widget.png'),
                size: 24.0,
                color: Colors.white,
              ),
              itemLabel: '组件',
            ),
            BottomBarItem(
              inActiveItem: ImageIcon(
                AssetImage('asset/image/page.png'),
                size: 24.0,
                color: Colors.blueAccent,
              ),
              activeItem: ImageIcon(
                AssetImage('asset/image/page.png'),
                size: 24.0,
                color: Colors.white,
              ),
              itemLabel: '页面',
            ),
            BottomBarItem(
              inActiveItem: ImageIcon(
                AssetImage('asset/image/app.png'),
                size: 24.0,
                color: Colors.blueAccent,
              ),
              activeItem: ImageIcon(
                AssetImage('asset/image/app.png'),
                size: 24.0,
                color: Colors.white,
              ),
              // inActiveItem: Icon(
              //   Icons.person,
              //   color: Colors.blueGrey,
              // ),
              // activeItem: Icon(
              //   Icons.person,
              //   color: Colors.yellow,
              // ),
              itemLabel: '探索',
            ),
          ],
          onTap: (index) {
            //log('current selected index $index');
            _pageController.jumpToPage(index);
          },
          kIconSize: 24.0,
        ),
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [WidgetScreen(), PageScreen(), AppScreen()],
        ),
      ),
    );
  }
}
