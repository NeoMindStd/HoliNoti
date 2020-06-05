import 'package:holinoti_customer/constants/strings.dart' as Strings;
import 'package:shared_preferences/shared_preferences.dart';

class SettingsBloc {
  final SharedPreferences _preferences;

  SettingsBloc(this._preferences);

  Future initTutorial() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(Strings.Preferences.SHOW_TUTORIAL);
  }
}
