import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:holinoti_admin/bloc/auth_bloc.dart';
import 'package:holinoti_admin/bloc/facility_bloc.dart';
import 'package:holinoti_admin/bloc/register_opening_info_bloc.dart';
import 'package:holinoti_admin/screens/auth.dart';
import 'package:holinoti_admin/screens/facility.dart';
import 'package:holinoti_admin/screens/profile.dart';
import 'package:holinoti_admin/screens/register_opening_info.dart';
import 'package:holinoti_admin/utils/data_manager.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final _tapIndexSubject = PublishSubject<int>();
  get tapIndexStream => _tapIndexSubject.stream;

  void onTapChanged(int index) => _tapIndexSubject.add(index);

  void moveToAuthPage(BuildContext context, AuthBloc authBloc) =>
      Navigator.push(
        context,
        platformPageRoute(
          context: context,
          builder: (context) => AuthPage(AuthBloc()),
        ),
      );

  void moveToProfilePage(BuildContext context) => Navigator.push(
        context,
        platformPageRoute(
          context: context,
          builder: (context) => ProfilePage(),
        ),
      );

  void moveToAuthOrProfilePage(BuildContext context) =>
      DataManager().currentUser == null
          ? moveToAuthPage(context, AuthBloc())
          : moveToProfilePage(context);

  void moveToFacilityPage(BuildContext context, FacilityBloc facilityBloc) =>
      Navigator.push(
        context,
        platformPageRoute(
          context: context,
          builder: (context) => FacilityPage(facilityBloc),
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
