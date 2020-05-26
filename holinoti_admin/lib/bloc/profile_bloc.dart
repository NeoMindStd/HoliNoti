import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/screens/widgets/profile/auto_login.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileBloc {
  final SharedPreferences _sharedPreferences;
  final _loginModeSubject = PublishSubject<bool>();

  ProfileBloc(this._sharedPreferences);

  get loginModeStream => _loginModeSubject.stream;
  get loginMode =>
      _sharedPreferences.getBool(Strings.Preferences.IS_AUTO_LOGIN_MODE) ??
      true;

  set loginMode(bool loginMode) {
    _sharedPreferences.setBool(
        Strings.Preferences.IS_AUTO_LOGIN_MODE, loginMode);
    _loginModeSubject.add(loginMode);
  }

  void moveToAutoLoginPage(BuildContext context) => Navigator.push(
        context,
        platformPageRoute(
          context: context,
          builder: (context) => AutoLoginPage(this),
        ),
      );

  void dispose() {
    _loginModeSubject.close();
  }
}
