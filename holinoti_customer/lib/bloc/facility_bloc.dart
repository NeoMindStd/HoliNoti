import 'package:holinoti_customer/constants/strings.dart' as Strings;
import 'package:holinoti_customer/data/facility.dart';
import 'package:holinoti_customer/data/opening_info.dart';
import 'package:holinoti_customer/utils/http_decoder.dart';
import 'package:http/http.dart' as http;

class FacilityBloc {
  final Facility facility;

  FacilityBloc(this.facility);

  Future<List<OpeningInfo>> requestOpeningInfo() async {
    if (facility.openingInfo.isNotEmpty) return facility.openingInfo;
    try {
      http.Response facilityResponse = await http.get(
        Strings.HttpApis.oisByFCodeURI(facility.code),
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
    }
  }

  void dispose() {}
}
