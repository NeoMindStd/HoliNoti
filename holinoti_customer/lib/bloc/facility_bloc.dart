import 'package:holinoti_customer/data/facility.dart';
import 'package:holinoti_customer/data/opening_info.dart';
import 'package:holinoti_customer/third_party_libraries/dio/lib/dio.dart';

class FacilityBloc {
  final Facility facility;

  FacilityBloc(this.facility);

  Future<List<OpeningInfo>> requestOpeningInfo() async {
    if (facility.openingInfo.isNotEmpty) return facility.openingInfo;
    try {
      Response openingInfoResponse = await Dio().get(
        "http://holinoti.tk:8080/holinoti/opening-infos/facility_code=${facility.code}",
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      print('Response: ${openingInfoResponse.data}');

      for (Map openingInfoJson in openingInfoResponse.data) {
        facility.openingInfo.add(OpeningInfo.fromJson(openingInfoJson));
      }
      return facility.openingInfo;
    } catch (e) {
      print(e);
      return [];
    }
  }

  void dispose() {}
}
