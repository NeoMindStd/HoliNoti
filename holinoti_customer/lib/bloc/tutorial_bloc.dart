import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holinoti_customer/bloc/home_bloc.dart';
import 'package:holinoti_customer/constants/strings.dart' as Strings;
import 'package:holinoti_customer/screens/home.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TutorialBloc {
  final SharedPreferences _preferences;
  double _currentPage;

  TutorialBloc(this._preferences) {
    _currentPage = 0;
  }

  final _currentPageSubject = PublishSubject<double>();

  get currentPageStream => _currentPageSubject.stream;
  get currentPage => _currentPage;

  void setCurrentPage(ValueNotifier<double> notifier, currentPage) {
    _currentPage = currentPage;
    notifier?.value = _currentPage;
    _currentPageSubject.add(_currentPage);
  }

  moveToHomePage(BuildContext context) async {
    _preferences.setBool(Strings.Preferences.SHOW_TUTORIAL, false);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage(HomeBloc())));
  }

  dispose() {
    _currentPageSubject.close();
    _currentPage = 0;
  }
}
