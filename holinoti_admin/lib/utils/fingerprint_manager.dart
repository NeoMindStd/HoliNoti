import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class FingerPrintManager {
  static final FingerPrintManager _fingerPrintManager =
      FingerPrintManager._internal();

  factory FingerPrintManager() => _fingerPrintManager;

  FingerPrintManager._internal();

  bool _hasBioAuth = false;
  LocalAuthentication localAuth = LocalAuthentication();

  bool get hasBioAuth => _hasBioAuth;

  /// Call it once at the start the app
  Future checkBio() async =>
      _hasBioAuth = await LocalAuthentication().canCheckBiometrics;

  Future certify() async {
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
    await localAuth.authenticateWithBiometrics(
        localizedReason: Strings.GlobalPage.BIO_AUTH_LOCALIZED_REASON,
        useErrorDialogs: false,
        androidAuthStrings: androidAuthStrings,
        iOSAuthStrings: iosStrings);
  }

  dispose() {
    _hasBioAuth = false;
    localAuth = null;
  }
}
