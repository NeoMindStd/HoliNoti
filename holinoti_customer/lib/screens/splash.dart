import 'dart:async';

import 'package:flutter/material.dart';
import 'package:holinoti_customer/bloc/home_bloc.dart';
import 'package:holinoti_customer/constants/strings.dart' as Strings;
import 'package:holinoti_customer/utils/data_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    autoLogIn();
    loadData();
  }

  //자동로그인
  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final _userId = prefs.getString('User Id') ?? null;
    final _userPassword = prefs.getString('User Password') ?? null;

    if (DataManager().currentUser != null) {
      setState(() {
        prefs.setString('User Id', DataManager().currentUser.account);
        prefs.setString('User Password', DataManager().currentUser.password);
      });
    } else {
      setState(() {
        DataManager().currentUser.account = _userId;
        DataManager().currentUser.password = _userPassword;
      });
    }
  }

  Future<Timer> loadData() async {
    return Timer(Duration(seconds: 2), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage(HomeBloc())));
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
