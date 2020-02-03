import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:holinoti_customer/bloc/facility_bloc.dart';
import 'package:holinoti_customer/constants/strings.dart' as Strings;
import 'package:holinoti_customer/data/facility.dart';
import 'package:holinoti_customer/screens/facility.dart';
import 'package:rxdart/rxdart.dart';

class FacilitiesBloc {
  List<Facility> facilities = [];

  FacilitiesBloc();

  Future<List<Facility>> requestFacilities() async {
    if(facilities.isNotEmpty) return facilities;
    try {
      Response facilityResponse = await Dio().get(
        "http://holinoti.tk:8080/holinoti/facilities/",
        options: Options(headers: {"Content-Type":"application/json"}),
      );

      print('Response: ${facilityResponse.data}');

      for(Map facilityJson in facilityResponse.data) {
        facilities.add(Facility.fromJson(facilityJson));
      }
      return facilities;

    } catch(e) {
      print(e);
      return [];
    }
  }

  void moveToFacilityPage(BuildContext context,
      Facility facility) => Navigator.push(
    context,
    platformPageRoute(
      context: context,
      builder: (context) => FacilityPage(FacilityBloc(facility)),
    ),
  );

  void dispose() {
  }

}