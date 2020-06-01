import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:holinoti_admin/bloc/second_password_bloc.dart';
import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/constants/themes.dart' as Themes;
import 'package:holinoti_admin/screens/second_password.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class SecondAuthManager {
  static final SecondAuthManager _secondAuthManager =
      SecondAuthManager._internal();

  factory SecondAuthManager() => _secondAuthManager;

  SecondAuthManager._internal();

  bool _hasBioAuth = false;
  LocalAuthentication localAuth = LocalAuthentication();

  bool get hasBioAuth => _hasBioAuth;

  /// Call it once at the start the app
  Future checkBio() async =>
      _hasBioAuth = await LocalAuthentication().canCheckBiometrics;

  Future<bool> certify(BuildContext context) async {
    bool authorized = false;
    if (_hasBioAuth) {
      const androidAuthStrings = const AndroidAuthMessages(
        signInTitle: Strings.GlobalPage.BIO_AUTH_SIGN_IN_TITLE,
        cancelButton: Strings.GlobalPage.BUTTON_CANCEL,
        goToSettingsButton: Strings.GlobalPage.BIO_AUTH_GOTO_SETTING,
        goToSettingsDescription:
            Strings.GlobalPage.BIO_AUTH_GOTO_SETTING_DESCRIPTION,
      );
      const iosStrings = const IOSAuthMessages(
        lockOut: Strings.GlobalPage.BIO_AUTH_SIGN_IN_TITLE,
        cancelButton: Strings.GlobalPage.BUTTON_CANCEL,
        goToSettingsButton: Strings.GlobalPage.BIO_AUTH_GOTO_SETTING,
        goToSettingsDescription:
            Strings.GlobalPage.BIO_AUTH_GOTO_SETTING_DESCRIPTION,
      );
      authorized = await localAuth.authenticateWithBiometrics(
              localizedReason: Strings.GlobalPage.BIO_AUTH_LOCALIZED_REASON,
              useErrorDialogs: false,
              androidAuthStrings: androidAuthStrings,
              iOSAuthStrings: iosStrings) ??
          false;
    } else {
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(statusBarColor: Themes.Colors.ORANGE_DARK));
      authorized = await Navigator.push(
            context,
            platformPageRoute(
              context: context,
              builder: (context) =>
                  SecondPasswordPage(SecondPasswordBloc(context)),
            ),
          ) ??
          false;
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(statusBarColor: Themes.Colors.ORANGE_LIGHT));
    }
    return authorized;
  }

  dispose() {
    _hasBioAuth = false;
    localAuth = null;
  }
}
