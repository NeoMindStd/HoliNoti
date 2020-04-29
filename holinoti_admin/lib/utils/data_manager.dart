import 'package:holinoti_admin/bloc/data_bloc.dart';
import 'package:holinoti_admin/data/user.dart';
import 'package:http_auth/http_auth.dart' as http_auth;

class DataManager {
  static final DataManager _dataManager = new DataManager._internal();
  static final DataBloc _dataBloc = DataBloc();

  factory DataManager() => _dataManager;

  DataManager._internal();

  User _currentUser;
  http_auth.BasicAuthClient client;

  User get currentUser => _currentUser;
  DataBloc get dataBloc => _dataBloc;

  set currentUser(User user) {
    _currentUser = user;
    _dataBloc.setUser(user);
  }

  dispose() {
    currentUser = null;
    client = null;
  }
}
