import 'dart:async';

import 'package:flutter/material.dart';
import 'package:holinoti_admin/bloc/facility_input_bloc.dart';
import 'package:holinoti_admin/bloc/home_bloc.dart';
import 'package:holinoti_admin/constants/strings.dart' as Strings;

import 'home.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<Timer> loadData() async {
    return Timer(Duration(seconds: 2), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomePage(HomeBloc(), FacilityInputBloc())));
  }

  @override
  Widget build(BuildContext context) {
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
