import 'package:holinoti_admin/data/user.dart';
import 'package:http_auth/http_auth.dart' as http_auth;

class DataManager {
  static final DataManager _dataManager = new DataManager._internal();

  factory DataManager() => _dataManager;

  DataManager._internal();

  User currentUser;
  http_auth.BasicAuthClient client;

  dispose() {
    currentUser = null;
    client = null;
  }
}
