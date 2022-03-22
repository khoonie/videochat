import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:intl/intl.dart';
import 'package:videochat/theme.dart';
//import 'package:videochat/theme.dart';
import 'pages/connect2.dart';
import 'package:videochat/app_theme.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'navigation_home_screen.dart';
import 'authentication/signup.dart';
import 'introduction/introduction_animation_screen.dart';
import 'dart:io';

import 'package:videochat/login/loginScreen.dart';
import 'package:videochat/authentication/login_signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  final format = DateFormat('HH:mm:ss');
  Logger.root.level = Level.FINE;
  Logger.root.onRecord.listen((record) {
    print('${format.format(record.time)}: ${record.message}');
  });
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  // remove the entry to enable intro screen again
  final success = await prefs.remove('seenIntro');

  final int? seenIntro = (prefs.getInt('seenIntro') ?? 0);
  if (seenIntro == 0) {
    await prefs.setInt('seenIntro', 1);
  }

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(MyApp(seenIntro: seenIntro)));
  //runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required int? seenIntro})
      : _seenIntro = seenIntro,
        super(key: key);
  final int? _seenIntro;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return MaterialApp(
      title: 'Videochat',
      debugShowCheckedModeBanner: false,
      //theme: LiveKitTheme().buildThemeData(context),
      //home: const ConnectPage2(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.iOS,
      ),
      //home: NavigationHomeScreen(),
      home: (_seenIntro == 0)
          ? const IntroductionAnimationScreen()
          : LoginSignupScreen(),
      //home: LoginScreen(),
    );
  }
}
