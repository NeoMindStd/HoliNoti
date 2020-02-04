import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holinoti_admin/constants/enums.dart' as Enums;
import 'package:holinoti_admin/data/facility.dart';
import 'package:holinoti_admin/data/manager.dart';
import 'package:holinoti_admin/third_party_libraries/dio/lib/dio.dart';
import 'package:holinoti_admin/utils/data_manager.dart';
import 'package:holinoti_admin/utils/dialog.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc {
  Enums.AuthMode authMode;

  AuthBloc({this.authMode = Enums.AuthMode.signIn});

  final _authModeSubject = PublishSubject<Enums.AuthMode>();
  get isLoginModeStream => _authModeSubject.stream;

  void setAuthMode(Enums.AuthMode authMode) {
    this.authMode = authMode;
    _authModeSubject.add(authMode);
  }

  /// 임시 메소드
  // TODO 서버에서 로그인하여 세션에서 유지되는 토큰을 받는 것으로 변경
  // TODO 비밀번호 암호화 하여 전달
  void signIn(BuildContext context, {String account, String password}) async {
    try {
      Response managerResponse = await Dio().get(
        "http://holinoti.tk:8080/holinoti/managers/account=${account}",
        options: Options(headers: {"Content-Type": "application/json"}),
      );
      Manager manager = Manager.fromJson(managerResponse.data);

      if (manager.password == password) {
        try {
          Response facilityResponse = await Dio().get(
            "http://holinoti.tk:8080/holinoti/facilities/${manager.facilityCode}",
            options: Options(headers: {"Content-Type": "application/json"}),
          );
          manager.facility = Facility.fromJson(facilityResponse.data);
        } catch (e) {
          print(e);
        }

        DataManager().signedIn = manager;
        print('Signed in as $manager');
        Navigator.pop(context);
      } else {
        signInFailed(context);
      }
    } catch (e) {
      print(e);
      signInFailed(context);
    }
  }

  void signInFailed(BuildContext context) {
    AppDialog(context).showConfirmDialog("아이디 또는 비밀번호가 잘못되었습니다.");
  }

  void signUp({String account, String password, String name}) async {
    try {
      Response response = await Dio().post(
        "http://holinoti.tk:8080/holinoti/managers",
        options: Options(headers: {"Content-Type": "application/json"}),
        data: {
          'account': account,
          'password': password,
          'name': name,
        },
      );
      print(response);
    } catch (e) {
      print(e);
    }
  }

  void dispose() {
    _authModeSubject.close();
  }
}
