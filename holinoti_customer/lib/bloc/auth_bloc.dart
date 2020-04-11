import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holinoti_customer/constants/enums.dart' as Enums;
import 'package:holinoti_customer/constants/nos.dart' as Nos;
import 'package:holinoti_customer/constants/strings.dart' as Strings;
import 'package:holinoti_customer/data/user.dart';
import 'package:holinoti_customer/utils/data_manager.dart';
import 'package:holinoti_customer/utils/dialog.dart';
import 'package:holinoti_customer/utils/http_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:http_auth/http_auth.dart' as http_auth;
import 'package:rxdart/rxdart.dart';
import 'package:sprintf/sprintf.dart';

class AuthBloc {
  Enums.AuthMode authMode;
  bool _obscureText;

  final _authModeSubject = PublishSubject<Enums.AuthMode>();
  final _obscureTextSubject = PublishSubject<bool>();

  AuthBloc({this.authMode = Enums.AuthMode.login}) {
    _obscureText = true;
  }

  get isObscureText => _obscureText;
  get isLoginModeStream => _authModeSubject.stream;
  get isObscureTextStream => _obscureTextSubject.stream;

  void setAuthMode(Enums.AuthMode authMode) {
    this.authMode = authMode;
    _authModeSubject.add(authMode);
  }

  void switchObscureTextMode({bool obscureText}) {
    _obscureText = obscureText ?? !_obscureText;
    _obscureTextSubject.add(_obscureText);
  }

  /// 임시 메소드
  // TODO 서버에서 로그인하여 세션에서 유지되는 토큰을 받는 것으로 변경
  // TODO 비밀번호 암호화 하여 전달
  void login(BuildContext context, {String account, String password}) async {
    try {
      http_auth.BasicAuthClient client =
          http_auth.BasicAuthClient(account, password);
      http.Response loginResponse = await client.get(
        "http://holinoti.tk:8080/holinoti/users/login",
        headers: {"Content-Type": "application/json; charset=utf-8"},
      );
      print('Response: $loginResponse');

      http.Response userResponse = await http.get(
        "http://holinoti.tk:8080/holinoti/users/account=$account",
        headers: {"Content-Type": "application/json; charset=utf-8"},
      );

      var decodedUserResponse = HttpDecoder.utf8Response(userResponse);
      print('Response: $decodedUserResponse');
      decodedUserResponse['authority'] = Enums.fromString(
          Enums.Authority.values, decodedUserResponse['authority']);

      User user = User.fromJson(decodedUserResponse);

      // TODO 시설 목록 받아오기

      DataManager().loggedInUser = user;
      print('Signed in as $user');
      Navigator.pop(context);
    } catch (e) {
      print(e);
      loginFailed(context);
    }
  }

  void loginFailed(BuildContext context) =>
      AppDialog(context).showConfirmDialog("아이디 또는 비밀번호가 잘못되었습니다.");

  void register(User user) async {
    try {
      http.Response userResponse = await http.post(
        "http://holinoti.tk:8080/holinoti/users/register",
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: userToJson(user),
      );

      var decodedUserResponse = HttpDecoder.utf8Response(userResponse);
      print('Response: $decodedUserResponse');
    } catch (e) {
      print(e);
    }
  }

  String passwordValidator(String password) {
    if (password.length < Nos.AuthPage.MIN_NO_OF_CHARACTERS)
      return Strings.AuthPage.ERROR_TO_SHORT;
    if (password.length > Nos.AuthPage.MAX_NO_OF_CHARACTERS)
      return Strings.AuthPage.ERROR_TO_LONG;
    List banned = RegExp(r"[^A-Za-z0-9!@#\$&*~]")
        .allMatches(password)
        .map((e) => e.group(0))
        .toList();
    if (banned.length > 0)
      return sprintf(
          Strings.AuthPage.ERROR_PROHIBITED_CHARACTERS, [banned.join(" ")]);
    int c = 0;
    if (RegExp(r"(?=.*[A-Za-z])").hasMatch(password)) c++;
    if (RegExp(r"(?=.*[0-9])").hasMatch(password)) c++;
    if (RegExp(r"(?=.*?[!@#\$&*~]).{8,}").hasMatch(password)) c++;
    if (c < 2) return Strings.AuthPage.ERROR_REQUIRE_COMBINE;
    return null;
  }

  void dispose() {
    _authModeSubject.close();
    _obscureTextSubject.close();
  }
}
