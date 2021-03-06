import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holinoti_customer/constants/enums.dart' as Enums;
import 'package:holinoti_customer/constants/nos.dart' as Nos;
import 'package:holinoti_customer/constants/strings.dart' as Strings;
import 'package:holinoti_customer/data/user.dart';
import 'package:holinoti_customer/utils/data_manager.dart';
import 'package:holinoti_customer/utils/dialog.dart';
import 'package:holinoti_customer/utils/http_decoder.dart';
import 'package:holinoti_customer/utils/notification_manager.dart';
import 'package:http/http.dart' as http;
import 'package:http_auth/http_auth.dart' as http_auth;
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprintf/sprintf.dart';

class AuthBloc {
  Enums.AuthMode authMode;
  bool _obscureText;
  Enums.Authority _authority;

  final _authModeSubject = PublishSubject<Enums.AuthMode>();
  final _obscureTextSubject = PublishSubject<bool>();
  final _authoritySubject = PublishSubject<Enums.Authority>();

  AuthBloc({this.authMode = Enums.AuthMode.login}) {
    _obscureText = true;
    _authority = Enums.Authority.normal;
  }

  get isObscureText => _obscureText;
  get isLoginModeStream => _authModeSubject.stream;
  get isObscureTextStream => _obscureTextSubject.stream;
  get authorityStream => _authoritySubject.stream;

  get authority => _authority;

  void setAuthMode(Enums.AuthMode authMode) {
    this.authMode = authMode;
    _authModeSubject.add(authMode);
  }

  void switchObscureTextMode({bool obscureText}) {
    _obscureText = obscureText ?? !_obscureText;
    _obscureTextSubject.add(_obscureText);
  }

  void setAuthority(Enums.Authority authority) {
    this._authority = authority;
    _authoritySubject.add(authority);
  }

  // TODO 패킷 암호화 하여 전달
  void login(BuildContext context, {String account, String password}) async {
    try {
      /*************************************************************************
       *                                 Login                                 *
       *************************************************************************/

      DataManager().client = http_auth.BasicAuthClient(account, password);
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
      await NotificationManager.getFirebaseToken();
      http.Response tokenUpdateResponse = await DataManager().client.put(
            Strings.HttpApis.userByIdURI(DataManager().currentUser.id),
            headers: {
              Strings.HttpApis.HEADER_NAME_CONTENT_TYPE:
                  Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE_JSON
            },
            body: userToJsonWithoutPassword(DataManager().currentUser),
          );
      print('Token Updated Status: ${tokenUpdateResponse.statusCode}');
      print('Token Updated: ${DataManager().currentUser}');

      final SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString(Strings.Preferences.ACCOUNT, account);
      prefs.setString(Strings.Preferences.PASSWORD, password);

      DataManager().dataBloc.queryFacilities();

      Navigator.pop(context);
    } catch (e) {
      print(e);
      loginFailed(context);
    }
  }

  void loginFailed(BuildContext context) => AppDialog(context)
      .showConfirmDialog(Strings.AuthPage.ERROR_WRONG_ACCOUNT);

  void register(User user) async {
    try {
      http.Response userResponse = await http.post(
        Strings.HttpApis.REGISTER_URI,
        headers: {
          Strings.HttpApis.HEADER_NAME_CONTENT_TYPE:
              Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE_JSON
        },
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
    _authoritySubject.close();
  }
}
