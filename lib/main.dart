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
import 'introduction/introduction_animation_screen.dart';
import 'dart:io';

import 'package:videochat/login/loginScreen.dart';

void main() async {
  final format = DateFormat('HH:mm:ss');
  Logger.root.level = Level.FINE;
  Logger.root.onRecord.listen((record) {
    print('${format.format(record.time)}: ${record.message}');
  });
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(MyApp()));
  //runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      home: const IntroductionAnimationScreen(),
      //home: LoginScreen(),
    );
  }
}
