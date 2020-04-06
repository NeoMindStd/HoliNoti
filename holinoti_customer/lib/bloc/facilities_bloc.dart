import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:holinoti_customer/bloc/facility_bloc.dart';
import 'package:holinoti_customer/data/facility.dart';
import 'package:holinoti_customer/screens/facility.dart';
import 'package:holinoti_customer/utils/http_decoder.dart';
import 'package:http/http.dart' as http;

class FacilitiesBloc {
  List<Facility> facilities = [];//이거 데이터 어떻게 구성되어있음? 임시 값 넣을려니 안들어감

  FacilitiesBloc();

  Future<List<Facility>> requestFacilities() async {
    if (facilities.isNotEmpty) return facilities;
    else return facilities;// 임시점검 코드 서버랑 잠시 끊어놓음 실전에 지울것
    /*try {
      http.Response facilityResponse = await http.get(
        "http://holinoti.tk:8080/holinoti/facilities",
        headers: {"Content-Type": "application/json; charset=utf-8"},
      );

      var decodedResponse = HttpDecoder.utf8Response(facilityResponse);
      print('Response: $decodedResponse');

      for (Map facilityJson in decodedResponse) {
        facilities.add(Facility.fromJson(facilityJson));
      }
      return facilities;
    } catch (e) {
      print(e);
      return [];
    }*/
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
