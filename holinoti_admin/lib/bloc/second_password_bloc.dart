import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holinoti_admin/constants/enums.dart' as Enums;
import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/utils/data_manager.dart';
import 'package:holinoti_admin/utils/dialog.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondPasswordBloc {
  final BuildContext context;

  Enums.SecondPassMode _initMode;
  String _secondPassword;
  SharedPreferences _preferences;
  String _inputPassword;
  String _initTempPass;

  final _initModeSubject = PublishSubject<Enums.SecondPassMode>();
  final _inputPasswordSubject = PublishSubject<String>();

  SecondPasswordBloc(this.context) {
    _initMode = Enums.SecondPassMode.verify;
    initPref();
    _inputPassword = "";
  }

  get initMode => _initMode;
  get inputPassword => _inputPassword;
  get inputPasswordStream => _inputPasswordSubject.stream;
  get initModeStream => _initModeSubject.stream;

  void initPref() async {
    _preferences = await SharedPreferences.getInstance();
    _secondPassword = _preferences.getString("secondPassword");
    if (_secondPassword == null && _initMode == Enums.SecondPassMode.verify)
      initPassword(context);
  }

  void initPassword(BuildContext context) {
    AppDialog(context).showInputDialog(
        message: Strings.SecondPasswordPage.INIT_PASSWORD_DIALOG_INPUT,
        hint: Strings.GlobalPage.PASSWORD,
        isObscureText: true,
        onConfirm: (String password) async {
          http.Response response = await DataManager().client.get(
            Strings.HttpApis.userCompare(
                DataManager().currentUser.account, password),
            headers: {
              Strings.HttpApis.HEADER_NAME_CONTENT_TYPE:
                  Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE_JSON
            },
          );
          if (response.statusCode == HttpStatus.ok &&
              response.body.toLowerCase() == Strings.GlobalPage.TRUE) {
            _initMode = Enums.SecondPassMode.init;
            _initModeSubject.add(_initMode);
            deletePassNum();
          } else {
            AppDialog(context).showConfirmDialog(
                Strings.SecondPasswordPage.INIT_PASSWORD_DIALOG_FAILED);
          }
        });
  }

  void checkPassword(BuildContext context) async {
    if (_secondPassword == _inputPassword) {
      Navigator.pop(context, true);
    } else {
      AppDialog(context).showConfirmDialog(
        Strings.SecondPasswordPage.CHECK_PASSWORD_DIALOG_FAILED,
        onConfirm: deleteAllPassNum,
      );
    }
  }

  void addPassNum(BuildContext context, int num) async {
    assert(0 <= num && num < 10);
    _inputPassword += num.toString();
    _inputPasswordSubject.add(_inputPassword);
    if (_inputPassword.length >= 6) {
      if (_initMode == Enums.SecondPassMode.verify) {
        checkPassword(context);
      } else if (_initMode == Enums.SecondPassMode.init) {
        _initTempPass = _inputPassword;
        _inputPassword = "";
        _inputPasswordSubject.add(_inputPassword);
        _initMode = Enums.SecondPassMode.initCheck;
        _initModeSubject.add(_initMode);
      } else {
        if (_initTempPass == _inputPassword) {
          await _preferences.setString(
              Strings.Preferences.SECOND_PASSWORD, _inputPassword);
          _secondPassword =
              _preferences.getString(Strings.Preferences.SECOND_PASSWORD);
          await AppDialog(context).showConfirmDialog(
            Strings.SecondPasswordPage.ADD_PASS_NUM_DIALOG_SUCCESS,
          );
          _inputPassword = _initTempPass = "";
          _inputPasswordSubject.add(_inputPassword);
          _initMode = Enums.SecondPassMode.verify;
          _initModeSubject.add(_initMode);
        } else {
          await AppDialog(context).showConfirmDialog(
            Strings.SecondPasswordPage.ADD_PASS_NUM_DIALOG_FAILED,
          );
          _inputPassword = "";
          _inputPasswordSubject.add(_inputPassword);
          _initMode = Enums.SecondPassMode.initCheck;
          _initModeSubject.add(_initMode);
        }
      }
    }
  }

  void deletePassNum() {
    if (_inputPassword.length > 0) {
      _inputPassword.substring(0, _inputPassword.length - 1);
    }
    _inputPasswordSubject.add(_inputPassword);
  }

  void deleteAllPassNum() {
    _inputPassword = "";
    _inputPasswordSubject.add(_inputPassword);
  }

  void dispose() {
    _initModeSubject.close();
    _inputPasswordSubject.close();
    _inputPassword = "";
    _initMode = Enums.SecondPassMode.verify;
  }
}
