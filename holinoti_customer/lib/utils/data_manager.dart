import 'package:holinoti_customer/data/user.dart';

/// Singleton
class DataManager {
  static final DataManager _dataManager = new DataManager._internal();

  factory DataManager() => _dataManager;

  DataManager._internal();

  User loggedInUser;

  dispose() {
    loggedInUser = null;
  }
}
