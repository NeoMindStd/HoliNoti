import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:holinoti_admin/bloc/auth_bloc.dart';
import 'package:holinoti_admin/bloc/register_facility_bloc.dart';
import 'package:holinoti_admin/bloc/register_opening_info_bloc.dart';
import 'package:holinoti_admin/screens/auth.dart';
import 'package:holinoti_admin/screens/register_faility.dart';
import 'package:holinoti_admin/screens/register_opening_info.dart';
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

  void moveToRegisterFacilityPage(
          BuildContext context, RegisterFacilityBloc registerFacilityBloc) =>
      Navigator.push(
        context,
        platformPageRoute(
          context: context,
          builder: (context) => RegisterFacilityPage(registerFacilityBloc),
        ),
      );

  void moveToRegisterOpeningInfoPage(BuildContext context,
          RegisterOpeningInfoBloc registerOpeningInfoBloc) =>
      Navigator.push(
        context,
        platformPageRoute(
          context: context,
          builder: (context) =>
              RegisterOpeningInfoPage(registerOpeningInfoBloc),
        ),
      );

  void dispose() {
    _tapIndexSubject.close();
  }
}
