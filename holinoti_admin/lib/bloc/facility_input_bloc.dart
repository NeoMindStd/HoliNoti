import 'package:holinoti_admin/constants/nos.dart' as Nos;
import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/data/facility.dart';
import 'package:holinoti_admin/utils/data_manager.dart';
import 'package:holinoti_admin/utils/http_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class FacilityInputBloc {
  Facility facility;
  bool _registerMode;

  final _facilitySubject = PublishSubject<Facility>();

  FacilityInputBloc({this.facility}) {
    facility ??= Facility();
    _registerMode = facility.code == Nos.Global.NOT_ASSIGNED_ID;
  }

  bool get isRegisterMode => _registerMode;
  get facilityStream => _facilitySubject.stream;

  Future<void> registerFacility() async {
    try {
      http.Response facilityResponse = _registerMode
          ? await DataManager().client.post(
                Strings.HttpApis.FACILITIES,
                headers: {
                  Strings.HttpApis.HEADER_NAME_CONTENT_TYPE:
                      Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE
                },
                body: facilityToJson(facility),
              )
          : await DataManager().client.put(
                Strings.HttpApis.facilityByCodeURI(facility.code),
                headers: {
                  Strings.HttpApis.HEADER_NAME_CONTENT_TYPE:
                      Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE
                },
                body: facilityToJson(facility),
              );

      var decodedFacilityResponse = HttpDecoder.utf8Response(facilityResponse);
      print('Response: $decodedFacilityResponse');

      try {
        if (_registerMode) {
          throw IndexError;
        }
        DataManager().currentUser.facilities[DataManager()
                .currentUser
                .facilities
                .indexWhere((item) => item.code == facility.code)] =
            Facility.fromJson(decodedFacilityResponse);
        print('Modified: ${DataManager().currentUser.facilities.last}');
      } catch (IndexError) {
        DataManager()
            .currentUser
            .facilities
            .add(Facility.fromJson(decodedFacilityResponse));

        print('Added: ${DataManager().currentUser.facilities.last}');
      }
    } catch (e) {
      print(e);
    }
  }

  void setFacilityName(String name) {
    facility.name = name;
    _facilitySubject.add(facility);
  }

  void setFacilityAddress(String address) {
    facility.address = address;
    _facilitySubject.add(facility);
  }

  void setFacilityPhoneNumber(String phoneNumber) {
    facility.phoneNumber = phoneNumber;
    _facilitySubject.add(facility);
  }

  void setFacilitySiteUrl(String siteUrl) {
    facility.siteUrl = siteUrl;
    _facilitySubject.add(facility);
  }

  void setFacilityComment(String comment) {
    facility.comment = comment;
    _facilitySubject.add(facility);
  }

  void setOpeningInfo(String openingInfo) {
    facility.openingInfo = openingInfo;
    _facilitySubject.add(facility);
  }

  void dispose() {
    _facilitySubject.close();
  }
}
