import 'package:geolocator/geolocator.dart';
import 'package:holinoti_admin/bloc/data_bloc.dart';
import 'package:holinoti_admin/data/facility.dart';
import 'package:holinoti_admin/data/user.dart';
import 'package:http_auth/http_auth.dart' as http_auth;

class DataManager {
  static final DataManager _dataManager = DataManager._internal();
  static final DataBloc _dataBloc = DataBloc();

  factory DataManager() => _dataManager;

  DataManager._internal();

  User _currentUser;
  http_auth.BasicAuthClient client;
  Position _currentPosition;
  List<Facility> _facilities = [];

  User get currentUser => _currentUser;
  DataBloc get dataBloc => _dataBloc;
  Position get currentPosition => _currentPosition;
  List<Facility> get facilities => _facilities;

  set currentUser(User user) {
    _currentUser = user;
    _dataBloc.setUser(user);
  }

  set facilities(List<Facility> facilities) {
    _facilities = facilities;
    _dataBloc.setFacilities(facilities);
  }

  void addFacility(Facility facility) {
    _facilities.add(facility);
    _dataBloc.setFacilities(facilities);
  }

  Future queryPosition() async {
    _currentPosition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  dispose() {
    queryPosition();
    currentUser = null;
    client = null;
    facilities = [];
  }
}
