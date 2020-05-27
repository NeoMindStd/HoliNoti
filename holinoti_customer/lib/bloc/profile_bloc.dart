import 'dart:html';

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

  void moveToAutoLoginPage(BuildContext context) => Navigator.push(
        context,
        platformPageRoute(
          context: context,
          builder: (context) => AutoLoginPage(this),
        ),
      );

  void secession(BuildContext context) {
    AppDialog(context).showInputDialog(
        message: "탈퇴를 원하시면 비밀번호를 입력해 주세요.",
        hint: "비밀번호",
        isObscureText: true,
        onConfirm: (String password) {
          AppDialog(context).showYesNoDialog(
              "정말로 탈퇴하시겠습니까? 탈퇴된 정보는 복구하실 수 없습니다.", onConfirm: () async {
            http.Response response = await DataManager().client.delete(
              "http://holinoti.tk:8080/holinoti/users/secession/${DataManager().currentUser.account}/$password",
              headers: {
                Strings.HttpApis.HEADER_NAME_CONTENT_TYPE:
                    Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE
              },
            );
            if (response.statusCode == HttpStatus.ok) {
              DataManager().dispose();
              Navigator.pop(context);
            } else {
              // TODO 팝업창 띄우기
            }
          });
        });
  }

  void dispose() {
    _loginModeSubject.close();
  }
}
