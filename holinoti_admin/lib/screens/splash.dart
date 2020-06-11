import 'package:flutter/material.dart';
import 'package:holinoti_admin/bloc/splash_bloc.dart';
import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/constants/themes.dart' as Themes;

class SplashPage extends StatelessWidget {
  final SplashBloc _splashBloc;
  SplashPage(this._splashBloc);

  @override
  Widget build(BuildContext context) {
    _splashBloc.loadData(context);
    return Scaffold(
        backgroundColor: Themes.Colors.ORANGE_LIGHT,
        body: Center(child: Image.asset(Strings.Assets.SPLASH_IMAGE)));
  }
}
