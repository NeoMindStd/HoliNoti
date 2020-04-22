import 'dart:async';

import 'package:flutter/material.dart';
import 'package:holinoti_customer/bloc/home_bloc.dart';

import 'home.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 2), onDoneLoading); //스플래시 떠 있는 시간
  }

  onDoneLoading() async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage(HomeBloc())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, //배경 색
        image: DecorationImage(
          image: AssetImage('assets/tempimageL.jpg'), //로고 이미지
        ),
      ),
    );
  }
}
