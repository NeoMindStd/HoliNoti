import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:holinoti_customer/bloc/facility_bloc.dart';
import 'package:holinoti_customer/constants/strings.dart' as Strings;
import 'package:holinoti_customer/data/facility.dart';
import 'package:holinoti_customer/screens/facility.dart';
import 'package:holinoti_customer/utils/http_decoder.dart';
import 'package:http/http.dart' as http;

class FacilitiesBloc {
  List<Facility> facilities = [];

  Future<List<Facility>> requestFacilities() async {
    if (facilities.isNotEmpty) return facilities;
    try {
      http.Response facilityResponse = await http.get(
        Strings.HttpApis.FACILITIES,
        headers: {"Content-Type": "application/json; charset=utf-8"},
      );

      var decodedResponse = HttpDecoder.utf8Response(facilityResponse);
      print('Response: $decodedResponse');

      for (Map facilityJson in decodedResponse) {
        facilities.add(Facility.fromJson(facilityJson));
      }
    } catch (e) {
      print(e);
    }
    return facilities;
  }

  void moveToFacilityPage(BuildContext context, Facility facility) =>
      Navigator.push(
        context,
        platformPageRoute(
          context: context,
          builder: (context) => FacilityPage(FacilityBloc(facility)),
        ),
      );

  void dispose() {}
}
