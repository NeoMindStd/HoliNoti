import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:holinoti_customer/bloc/auth_bloc.dart';
import 'package:holinoti_customer/bloc/facility_bloc.dart';
import 'package:holinoti_customer/bloc/profile_bloc.dart';
import 'package:holinoti_customer/constants/nos.dart' as Nos;
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
  int distanceIndex;

  HomeBloc() {
    distanceIndex = 2;
  }

  final _tapIndexSubject = PublishSubject<int>();
  final _distanceIndexSubject = PublishSubject<int>();
  get tapIndexStream => _tapIndexSubject.stream;
  get distanceIndexStream => _distanceIndexSubject.stream;

  void onTapChanged(int index) => _tapIndexSubject.add(index);
  void onDistanceIndexChanged(int distanceIndex) {
    this.distanceIndex = distanceIndex;
    _distanceIndexSubject.add(distanceIndex);
  }

  void search(String name) async {
    name = name.trim();
    int distance = Nos.HomePage.DISTANCE_LIST[distanceIndex];
    print("========Search========");
    http.Response facilitiesResponse;
    if (distance > Nos.Global.WITHOUT_DISTANCE) {
      await DataManager().queryPosition();
      print(
          "Name: $name, ${DataManager().currentPosition}, Distance: $distance");
      if (name != null && name != "") {
        facilitiesResponse = await http.get(
          Strings.HttpApis.facilitiesByCoordinatesAndName(
            DataManager().currentPosition.longitude,
            DataManager().currentPosition.latitude,
            distance,
            name,
          ),
          headers: {
            Strings.HttpApis.HEADER_NAME_CONTENT_TYPE:
                Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE_JSON
          },
        );
      } else {
        facilitiesResponse = await http.get(
          Strings.HttpApis.facilitiesByCoordinates(
            DataManager().currentPosition.longitude,
            DataManager().currentPosition.latitude,
            distance,
          ),
          headers: {
            Strings.HttpApis.HEADER_NAME_CONTENT_TYPE:
                Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE_JSON
          },
        );
      }
    } else {
      print("Name: $name");
      if (name != null && name != "") {
        facilitiesResponse = await http.get(
          Strings.HttpApis.facilitiesByName(
            name,
          ),
          headers: {
            Strings.HttpApis.HEADER_NAME_CONTENT_TYPE:
                Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE_JSON
          },
        );
      } else {
        facilitiesResponse = await http.get(
          Strings.HttpApis.facilitiesURI(),
          headers: {
            Strings.HttpApis.HEADER_NAME_CONTENT_TYPE:
                Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE_JSON
          },
        );
      }
    }
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
    print("query results: ${DataManager().facilities}");
    print("=====================");

    DataManager().dataBloc.queryFacilityImages();
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
    _distanceIndexSubject.close();
    distanceIndex = 2;
  }
}
