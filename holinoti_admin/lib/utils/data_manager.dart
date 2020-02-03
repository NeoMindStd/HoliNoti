import 'package:holinoti_admin/data/manager.dart';

class DataManager {
  static final DataManager _dataManager = new DataManager._internal();

  factory DataManager() => _dataManager;

  DataManager._internal();

  Manager signedIn;

  dispose() {
    signedIn = null;
  }
}