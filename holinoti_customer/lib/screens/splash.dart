import 'package:flutter/material.dart';
import 'package:holinoti_customer/bloc/splash_bloc.dart';
import 'package:holinoti_customer/constants/strings.dart' as Strings;

class SplashPage extends StatelessWidget {
  final SplashBloc _splashBloc;
  SplashPage(this._splashBloc);
  @override
  Widget build(BuildContext context) {
    _splashBloc.loadData(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(Strings.Assets.TEMP_IMAGE_L),
        ),
      ),
    );
  }
}
