import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holinoti_admin/constants/enums.dart' as Enums;
import 'package:holinoti_admin/constants/nos.dart' as Nos;
import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/data/facility.dart';
import 'package:holinoti_admin/data/relation_af.dart';
import 'package:holinoti_admin/data/user.dart';
import 'package:holinoti_admin/utils/data_manager.dart';
import 'package:holinoti_admin/utils/dialog.dart';
import 'package:holinoti_admin/utils/http_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:http_auth/http_auth.dart' as http_auth;
import 'package:rxdart/rxdart.dart';
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

  // TODO 비밀번호 암호화 하여 전달
  void login(BuildContext context, {String account, String password}) async {
    try {
      /*************************************************************************
       *                                 Login                                 *
       *************************************************************************/
      DataManager().client = http_auth.BasicAuthClient(account, password);
      http.Response userResponse = await DataManager().client.post(
        "http://holinoti.tk:8080/holinoti/users/login",
        headers: {"Content-Type": "application/json; charset=utf-8"},
      );

      var decodedUserResponse = HttpDecoder.utf8Response(userResponse);
      print('Response: $decodedUserResponse');
      decodedUserResponse['authority'] = Enums.fromString(
          Enums.Authority.values, decodedUserResponse['authority']);

      DataManager().currentUser = User.fromJson(decodedUserResponse);
      print('Login: ${DataManager().currentUser}');

      /*************************************************************************
       *                           Get Bookmark List                           *
       * Exclude if relationAF.role is Enums.Role.customer                     *
       *************************************************************************/

      http.Response relationAFsResponse = await DataManager().client.get(
        "http://holinoti.tk:8080/holinoti/relation_afs/user_id=${DataManager().currentUser.id}",
        headers: {"Content-Type": "application/json; charset=utf-8"},
      );
      List decodedRelationAFResponse =
          HttpDecoder.utf8Response(relationAFsResponse);
      print('decodedRelationAFResponse: $decodedRelationAFResponse');

      List decodedFacilitiesResponse = [];

      decodedRelationAFResponse = decodedRelationAFResponse
          .map((relationAFMap) {
            relationAFMap['role'] =
                Enums.fromString(Enums.Role.values, relationAFMap['role']);
            return RelationAF.fromJson(relationAFMap);
          })
          .where((relationAF) => relationAF.role != Enums.Role.customer)
          .toList();

      for (RelationAF relationAF in decodedRelationAFResponse) {
        decodedFacilitiesResponse
            .add(HttpDecoder.utf8Response(await DataManager().client.get(
          "http://holinoti.tk:8080/holinoti/facilities/code=${relationAF.facilityCode}",
          headers: {"Content-Type": "application/json; charset=utf-8"},
        )));
      }

      DataManager().currentUser.facilities =
          decodedFacilitiesResponse.map((e) => Facility.fromJson(e)).toList();

      print('Facilities: ${DataManager().currentUser.facilities}');

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
    _authoritySubject.close();
  }
}
