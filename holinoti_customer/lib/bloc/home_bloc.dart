import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:holinoti_customer/bloc/auth_bloc.dart';
import 'package:holinoti_customer/bloc/facility_bloc.dart';
import 'package:holinoti_customer/bloc/profile_bloc.dart';
import 'package:holinoti_customer/constants/strings.dart' as Strings;
import 'package:holinoti_customer/data/facility.dart';
import 'package:holinoti_customer/screens/auth.dart';
import 'package:holinoti_customer/screens/facility.dart';
import 'package:holinoti_customer/screens/profile.dart';
import 'package:holinoti_customer/utils/data_manager.dart';
import 'package:holinoti_customer/utils/http_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBloc {
  final _tapIndexSubject = PublishSubject<int>();
  get tapIndexStream => _tapIndexSubject.stream;

  void onTapChanged(int index) => _tapIndexSubject.add(index);

  void search(String name) async {
    await DataManager().queryPosition();
    print("========Where========");
    print(DataManager().currentPosition);
    print("====================");
    http.Response facilitiesResponse = await http.get(
      Strings.HttpApis.facilitiesByName(
        DataManager().currentPosition.longitude,
        DataManager().currentPosition.latitude,
        500,
        name,
      ),
      headers: {
        Strings.HttpApis.HEADER_NAME_CONTENT_TYPE:
            Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE_JSON
      },
    );
    var decodedFacilitiesResponse =
        HttpDecoder.utf8Response(facilitiesResponse);
    print(decodedFacilitiesResponse);
    DataManager().facilities = [];
    for (var facilityResponse in decodedFacilitiesResponse) {
      try {
        DataManager().addFacility(Facility.fromJson(facilityResponse));
      } catch (e) {
        print(e);
      }
    }
    print("queryByPosition: ${DataManager().facilities}");
  }

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
