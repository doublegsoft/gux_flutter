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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gux/gux/bloc/form_bloc.dart';
import 'package:gux/gux/bloc/list_bloc.dart';
import 'package:gux/provider/schedule_provider.dart';
import 'package:gux/widget/gx_page_visibility_mixin.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import '/welcome.dart';
import 'gux/screen/app_screen.dart';
import 'gux/screen/page_screen.dart';
import 'gux/screen/widget_screen.dart';

import 'package:gux/design/styles.dart' as styles;

class CustomAnimation extends EasyLoadingAnimation {

  CustomAnimation();

  @override
  Widget buildWidget(
      Widget child,
      AnimationController controller,
      AlignmentGeometry alignment,
      ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}

void main() {
  initializeDateFormatting().then((_) => runApp(GUX()));
}

class GUX extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => GUXState();

}

class GUXState extends State<GUX> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false
      ..customAnimation = CustomAnimation();
  }

  @override
  Widget build(BuildContext context) {
    styles.init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<FormBloc>(
          create: (context) => FormBloc(),
        ),
        BlocProvider<ListBloc>(
          create: (context) => ListBloc(),
        ),
        ChangeNotifierProvider(create: (_) => ScheduleProvider()),
      ],
      child: MaterialApp(
        navigatorObservers: [],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: false,
        ),
        // home: WelcomeScreen(),
        routes: {
          '/': (conetxt) => WelcomePage(),
          '/main': (context) => MainPage(),
        },
        supportedLocales: const [
          Locale('zh', 'CN'), // 中文
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        builder: EasyLoading.init(),
      ),
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
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: false,
        appBar: null,
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
          indicatorColor: styles.colorPrimary,
          selectedIndex: _currentPageIndex,
          destinations: <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home, color: styles.colorTextInverse),
              icon: Icon(Icons.home_outlined, color: styles.colorTextPrimary,),
              label: '组件',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.find_in_page, color: styles.colorTextInverse),
              icon: Icon(Icons.find_in_page_outlined, color: styles.colorTextPrimary),
              label: '页面',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.touch_app, color: styles.colorTextInverse),
              icon: Icon(Icons.touch_app_outlined, color: styles.colorTextPrimary),
              label: '应用',
            ),
          ],
        ),
        body: [WidgetScreen(), PageScreen(), AppScreen()][_currentPageIndex],
      ),
    );
  }

}
