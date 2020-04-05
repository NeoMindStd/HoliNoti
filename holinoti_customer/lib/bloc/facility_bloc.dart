import 'package:holinoti_customer/data/facility.dart';
import 'package:holinoti_customer/data/opening_info.dart';
import 'package:holinoti_customer/utils/http_decoder.dart';
import 'package:http/http.dart' as http;

class FacilityBloc {
  final Facility facility;

  FacilityBloc(this.facility);

  Future<List<OpeningInfo>> requestOpeningInfo() async {
    if (facility.openingInfo.isNotEmpty) return facility.openingInfo;
    else return facility.openingInfo;//임시 점검 코드 아래는 서버 연결 잠시 끊어놓은거 실전에는 지울것
    /*
    try {
      http.Response facilityResponse = await http.get(
        "http://holinoti.tk:8080/holinoti/opening-infos/facility_code=${facility.code}",
        headers: {"Content-Type": "application/json; charset=utf-8"},
      );

      var decodedResponse = HttpDecoder.utf8Response(facilityResponse);
      print('Response: $decodedResponse');

      for (Map openingInfoJson in decodedResponse) {
        facility.openingInfo.add(OpeningInfo.fromJson(openingInfoJson));
      }
      return facility.openingInfo;
    } catch (e) {
      print(e);
      return [];
    }*/
  }

  void dispose() {}
}
