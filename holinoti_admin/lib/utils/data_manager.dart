import 'package:holinoti_admin/data/user.dart';

class DataManager {
  static final DataManager _dataManager = new DataManager._internal();

  factory DataManager() => _dataManager;

  DataManager._internal();

  User loggedInUser;

  dispose() {
    loggedInUser = null;
  }
}
