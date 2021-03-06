import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holinoti_admin/bloc/facility_input_bloc.dart';
import 'package:holinoti_admin/bloc/home_bloc.dart';
import 'package:holinoti_admin/bloc/tutorial_bloc.dart';
import 'package:holinoti_admin/constants/enums.dart' as Enums;
import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/data/user.dart';
import 'package:holinoti_admin/screens/home.dart';
import 'package:holinoti_admin/screens/tutorial.dart';
import 'package:holinoti_admin/utils/data_manager.dart';
import 'package:holinoti_admin/utils/http_decoder.dart';
import 'package:holinoti_admin/utils/notification_manager.dart';
import 'package:holinoti_admin/utils/second_auth_manager.dart';
import 'package:http/http.dart' as http;
import 'package:http_auth/http_auth.dart' as http_auth;
import 'package:shared_preferences/shared_preferences.dart';

class SplashBloc {
  Future autoLogIn() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      String account = prefs.getString(Strings.Preferences.ACCOUNT);
      String password = prefs.getString(Strings.Preferences.PASSWORD);

      if (account == null || password == null) return;

      DataManager().client = http_auth.BasicAuthClient(
        account,
        password,
      );
      http.Response userResponse = await DataManager().client.post(
        Strings.HttpApis.LOGIN_URI,
        headers: {
          Strings.HttpApis.HEADER_NAME_CONTENT_TYPE:
              Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE_JSON
        },
      );

      var decodedUserResponse = HttpDecoder.utf8Response(userResponse);
      print('Response: $decodedUserResponse');
      decodedUserResponse['authority'] = Enums.fromString(
          Enums.Authority.values, decodedUserResponse['authority']);

      DataManager().currentUser = User.fromJson(decodedUserResponse);
      print('Login: ${DataManager().currentUser}');
    } catch (e) {
      print(e);
    }
  }

  loadData(BuildContext context) async {
    NotificationManager().initFirebase();
    SecondAuthManager().checkBio();
    if ((await SharedPreferences.getInstance())
            .getBool(Strings.Preferences.IS_AUTO_LOGIN_MODE) ??
        true) {
      await autoLogIn();
    }
    await DataManager().dataBloc.queryFacilities();
    onDoneLoading(context);
  }

  onDoneLoading(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool(Strings.Preferences.SHOW_TUTORIAL) ?? true) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => TutorialPage(TutorialBloc(pref))));
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => HomePage(HomeBloc(), FacilityInputBloc())),
      );
    }
  }
}
