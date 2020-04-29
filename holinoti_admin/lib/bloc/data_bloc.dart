import 'package:holinoti_admin/data/user.dart';
import 'package:rxdart/rxdart.dart';

class DataBloc {
  final _currentUserSubject = PublishSubject<User>();

  get currentUserStream => _currentUserSubject.stream;

  void setUser(User user) {
    _currentUserSubject.add(user);
  }

  void dispose() {
    _currentUserSubject.close();
  }
}
