import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:holinoti_customer/bloc/auth_bloc.dart';
import 'package:holinoti_customer/bloc/facility_bloc.dart';
import 'package:holinoti_customer/bloc/profile_bloc.dart';
import 'package:holinoti_customer/screens/auth.dart';
import 'package:holinoti_customer/screens/facility.dart';
import 'package:holinoti_customer/screens/profile.dart';
import 'package:holinoti_customer/utils/data_manager.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  void moveToProfilePage(BuildContext context) async {
    ProfileBloc profileBloc =
        ProfileBloc(await SharedPreferences.getInstance());
    Navigator.push(
      context,
      platformPageRoute(
        context: context,
        builder: (context) => ProfilePage(profileBloc),
      ),
    );
  }

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

  void dispose() {
    _tapIndexSubject.close();
  }
}
