import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:holinoti_customer/constants/strings.dart' as Strings;
import 'package:holinoti_customer/screens/widgets/profile/auto_login.dart';
import 'package:holinoti_customer/utils/data_manager.dart';
import 'package:holinoti_customer/utils/dialog.dart';
import 'package:http/http.dart' as http;
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

  void authPrefInit() async {
    _sharedPreferences.remove(Strings.Preferences.ACCOUNT);
    _sharedPreferences.remove(Strings.Preferences.PASSWORD);
    _sharedPreferences.remove(Strings.Preferences.IS_AUTO_LOGIN_MODE);
    DataManager().dispose();
    DataManager().dataBloc.queryFacilities();
  }

  void moveToAutoLoginPage(BuildContext context) => Navigator.push(
        context,
        platformPageRoute(
          context: context,
          builder: (context) => AutoLoginPage(this),
        ),
      );

  void secession(BuildContext context) {
    AppDialog(context).showInputDialog(
        message: Strings.ProfilePage.SECESSION_DIALOG_INPUT,
        hint: Strings.GlobalPage.PASSWORD,
        isObscureText: true,
        onConfirm: (String password) {
          AppDialog(context).showYesNoDialog(
              Strings.ProfilePage.SECESSION_DIALOG_YES_NO, onConfirm: () async {
            http.Response response = await DataManager().client.delete(
              Strings.HttpApis.userSecession(
                  DataManager().currentUser.account, password),
              headers: {
                Strings.HttpApis.HEADER_NAME_CONTENT_TYPE:
                    Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE_JSON
              },
            );
            if (response.statusCode == HttpStatus.ok) {
              authPrefInit();
              Navigator.pop(context);
            } else {
              AppDialog(context).showConfirmDialog(
                  Strings.ProfilePage.SECESSION_DIALOG_FAILED);
            }
          });
        });
  }

  void logout(BuildContext context) async {
    AppDialog(context).showYesNoDialog(Strings.ProfilePage.LOGOUT_DIALOG_YES_NO,
        onConfirm: () async {
      await DataManager().client.get(
        Strings.HttpApis.LOGOUT_URI,
        headers: {
          Strings.HttpApis.HEADER_NAME_CONTENT_TYPE:
              Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE_JSON
        },
      );
      authPrefInit();
      Navigator.pop(context);
    });
  }

  void dispose() {
    _loginModeSubject.close();
  }
}
