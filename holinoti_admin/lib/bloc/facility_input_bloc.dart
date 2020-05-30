import 'package:flutter/cupertino.dart';
import 'package:holinoti_admin/constants/nos.dart' as Nos;
import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/data/facility.dart';
import 'package:holinoti_admin/data/kakao_address.dart';
import 'package:holinoti_admin/utils/data_manager.dart';
import 'package:holinoti_admin/utils/http_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class FacilityInputBloc {
  Facility facility;
  bool _registerMode;
  List<KakaoAddress> addresses;

  final _facilitySubject = PublishSubject<Facility>();
  final _addressSubject = PublishSubject<List<KakaoAddress>>();

  FacilityInputBloc({this.facility}) {
    facility ??= Facility();
    _registerMode = facility.code == Nos.Global.NOT_ASSIGNED_ID;
    addresses = [];
  }

  bool get isRegisterMode => _registerMode;
  get facilityStream => _facilitySubject.stream;
  get addressStream => _addressSubject.stream;

  Future queryAddress(String query,
      {int page = 1, int addressSize = 10}) async {
    http.Response response = await http.post(
      Strings.HttpApis.API_URL_KAKAO_MAP_QUERY,
      headers: {
        Strings.HttpApis.API_AUTHORIZATION:
            Strings.HttpApis.API_KEY_KAKAO_MAP_QUERY,
        Strings.HttpApis.HEADER_NAME_CONTENT_TYPE:
            Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE_URLENCODED,
      },
      body: {
        "query": query,
        "page": page.toString(),
        "AddressSize": addressSize.toString(),
      },
    );
    print(response.statusCode);
    print(response.headers);
    print(response.body);
    var decodedResponse = HttpDecoder.utf8Response(response);
    addresses = [];
    for (var decodedAddress in decodedResponse["documents"]) {
      addresses.add(KakaoAddress.fromJson(decodedAddress["road_address"]));
    }
    _addressSubject.add(addresses);
    print(addresses);
  }

  void tapKakaoAddress(BuildContext context, KakaoAddress kakaoAddress) {
    facility.address =
        (kakaoAddress.addressName + " " + kakaoAddress.buildingName).trim();
    facility.x = kakaoAddress.x;
    facility.y = kakaoAddress.y;
    Navigator.pop(context);
  }

  Future<void> registerFacility() async {
    try {
      http.Response facilityResponse = _registerMode
          ? await DataManager().client.post(
                Strings.HttpApis.FACILITIES,
                headers: {
                  Strings.HttpApis.HEADER_NAME_CONTENT_TYPE:
                      Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE_JSON
                },
                body: facilityToJson(facility),
              )
          : await DataManager().client.put(
                Strings.HttpApis.facilityByCodeURI(facility.code),
                headers: {
                  Strings.HttpApis.HEADER_NAME_CONTENT_TYPE:
                      Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE_JSON
                },
                body: facilityToJson(facility),
              );

      var decodedFacilityResponse = HttpDecoder.utf8Response(facilityResponse);
      print('Response: $decodedFacilityResponse');

      try {
        if (_registerMode) {
          throw IndexError;
        }
        DataManager().facilities[DataManager()
                .facilities
                .indexWhere((item) => item.code == facility.code)] =
            Facility.fromJson(decodedFacilityResponse);
        print('Modified: ${DataManager().facilities.last}');
      } catch (IndexError) {
        DataManager()
            .facilities
            .add(Facility.fromJson(decodedFacilityResponse));

        print('Added: ${DataManager().facilities.last}');
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
    _addressSubject.close();
    addresses = [];
  }
}
