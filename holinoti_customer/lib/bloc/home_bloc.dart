import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:holinoti_customer/bloc/auth_bloc.dart';
import 'package:holinoti_customer/bloc/facilities_bloc.dart';
import 'package:holinoti_customer/screens/auth.dart';
import 'package:holinoti_customer/screens/facilities.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final _tapIndexSubject = PublishSubject<int>();
  get tapIndexStream => _tapIndexSubject.stream;

  void onTapChanged(int index) {
    _tapIndexSubject.add(index);
  }

  void moveToAuthPage(BuildContext context, AuthBloc authBloc) =>
      Navigator.push(
        context,
        platformPageRoute(
          context: context,
          builder: (context) => AuthPage(AuthBloc()),
        ),
      );

  void moveToFacilitiesPage(
          BuildContext context, FacilitiesBloc facilitiesBloc) =>
      Navigator.push(
        context,
        platformPageRoute(
          context: context,
          builder: (context) => FacilitiesPage(facilitiesBloc),
        ),
      );

  void dispose() {
    _tapIndexSubject.close();
  }
}
