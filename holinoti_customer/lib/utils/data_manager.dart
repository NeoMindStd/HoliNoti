import 'package:holinoti_customer/data/user.dart';

class DataManager {
  static final DataManager _dataManager = new DataManager._internal();

  factory DataManager() => _dataManager;

  DataManager._internal();

  User signedIn;

  dispose() {
    signedIn = null;
  }
}
