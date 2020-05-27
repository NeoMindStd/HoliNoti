import 'package:holinoti_admin/data/facility.dart';
import 'package:holinoti_admin/data/user.dart';
import 'package:rxdart/rxdart.dart';

class DataBloc {
  final _currentUserSubject = PublishSubject<User>();
  final _facilitiesSubject = PublishSubject<List<Facility>>();

  get currentUserStream => _currentUserSubject.stream;
  get facilitiesStream => _facilitiesSubject.stream;

  void setUser(User user) {
    _currentUserSubject.add(user);
  }

  void setFacilities(List<Facility> facilities) {
    _facilitiesSubject.add(facilities);
  }

  void dispose() {
    _currentUserSubject.close();
    _facilitiesSubject.close();
  }
}
