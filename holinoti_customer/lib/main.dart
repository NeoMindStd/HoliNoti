import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:holinoti_customer/bloc/splash_bloc.dart';
import 'package:holinoti_customer/constants/strings.dart' as Strings;
import 'package:holinoti_customer/constants/themes.dart' as Themes;
import 'package:holinoti_customer/screens/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Themes.Colors.ORANGE_LIGHT));
    return MaterialApp(
      title: Strings.GlobalPage.APP_NAME_KR,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Themes.Colors.ORANGE,
        accentColor: Themes.Colors.ORANGE,
      ),
      home: SplashPage(SplashBloc()),
    );
  }
}
