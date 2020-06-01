import 'package:flutter/cupertino.dart';
import 'package:holinoti_admin/constants/nos.dart' as Nos;
import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/data/facility.dart';
import 'package:holinoti_admin/data/kakao_address.dart';
import 'package:holinoti_admin/utils/data_manager.dart';
import 'package:holinoti_admin/utils/dialog.dart';
import 'package:holinoti_admin/utils/http_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class FacilityInputBloc {
  Facility facility;
  bool _registerMode;
  List<KakaoAddress> addresses;
  TextEditingController nameController;
  TextEditingController commentController;
  TextEditingController urlController;
  TextEditingController phoneNumberController;
  TextEditingController openingInfoController;

  final _facilitySubject = PublishSubject<Facility>();
  final _addressSubject = PublishSubject<List<KakaoAddress>>();

  FacilityInputBloc({this.facility}) {
    facility ??= Facility();
    _registerMode = facility.code == Nos.Global.NOT_ASSIGNED_ID;
    addresses = [];
    nameController = TextEditingController(text: facility.name);
    commentController = TextEditingController(text: facility.comment);
    urlController = TextEditingController(text: facility.siteUrl);
    phoneNumberController = TextEditingController(text: facility.phoneNumber);
    openingInfoController = TextEditingController(text: facility.openingInfo);
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
        Strings.HttpApis.API_REQUEST_BODY_KAKAO_MAP_QUERY: query,
        Strings.HttpApis.API_REQUEST_BODY_KAKAO_MAP_PAGE: page.toString(),
        Strings.HttpApis.API_REQUEST_BODY_KAKAO_MAP_ADDRESS_SIZE:
            addressSize.toString(),
      },
    );
    print(response.statusCode);
    print(response.headers);
    print(response.body);
    var decodedResponse = HttpDecoder.utf8Response(response);
    addresses = [];
    for (var decodedAddress in decodedResponse[
        Strings.HttpApis.API_RESPONSE_BODY_KAKAO_MAP_DOCUMENTS]) {
      addresses.add(KakaoAddress.fromJson(decodedAddress[
          Strings.HttpApis.API_RESPONSE_BODY_KAKAO_MAP_ROAD_ADDRESS]));
    }
    _addressSubject.add(addresses);
    print(addresses);
  }

  void tapKakaoAddress(BuildContext context, KakaoAddress kakaoAddress) {
    facility.address =
        (kakaoAddress.addressName + " " + kakaoAddress.buildingName).trim();
    facility.x = kakaoAddress.x;
    facility.y = kakaoAddress.y;
    _facilitySubject.add(facility);
    Navigator.pop(context);
  }

  Future<void> registerFacility() async {
    try {
      http.Response facilityResponse = _registerMode
          ? await DataManager().client.post(
                Strings.HttpApis.facilitiesURI(),
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

      print(facilityResponse.statusCode);
      print(facilityResponse.headers);
      print(facilityResponse.body);
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
      DataManager().dataBloc.setFacilities(DataManager().facilities);
    } catch (e) {
      print(e);
    }
  }

  Future deleteFacility(BuildContext context) async {
    assert(facility.code != Nos.Global.NOT_ASSIGNED_ID);
    AppDialog(context).showYesNoDialog(
        Strings.FacilityPage.DELETE_DIALOG_YES_NO, onConfirm: () async {
      http.Response facilityResponse = await DataManager().client.delete(
        Strings.HttpApis.facilityByCodeURI(facility.code),
        headers: {
          Strings.HttpApis.HEADER_NAME_CONTENT_TYPE:
              Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE_JSON
        },
      );
      AppDialog(context).showConfirmDialog(
          Strings.FacilityPage.DELETE_DIALOG_CONFIRM,
          onConfirm: () => Navigator.pop(context));
    });
  }

  void dispose() {
    facility = Facility();
    addresses = [];
    nameController = TextEditingController(text: facility.name);
    commentController = TextEditingController(text: facility.comment);
    urlController = TextEditingController(text: facility.siteUrl);
    phoneNumberController = TextEditingController(text: facility.phoneNumber);
    openingInfoController = TextEditingController(text: facility.openingInfo);
    _facilitySubject.close();
    _addressSubject.close();
  }
}
