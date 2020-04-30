import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holinoti_admin/constants/nos.dart' as Nos;
import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/data/facility.dart';
import 'package:holinoti_admin/data/opening_info.dart';
import 'package:holinoti_admin/utils/data_manager.dart';
import 'package:holinoti_admin/utils/http_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:sprintf/sprintf.dart';

class FacilityInputBloc {
  Facility facility;
  OpeningInfo openingInfo;
  bool _registerMode;

  final _facilitySubject = PublishSubject<Facility>();
  final _openingInfoSubject = PublishSubject<OpeningInfo>();

  FacilityInputBloc({this.facility, this.openingInfo}) {
    facility ??= Facility();
    openingInfo ??= OpeningInfo();
    _registerMode = facility.code == Nos.Global.NOT_ASSIGNED_ID;
  }

  bool get isRegisterMode => _registerMode;
  get facilityStream => _facilitySubject.stream;
  get openingInfoStream => _openingInfoSubject.stream;

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

      openingInfo.facilityCode = DataManager().currentUser.facilities.last.code;
      try {
        http.Response openingInfoResponse =
            openingInfo.id == Nos.Global.NOT_ASSIGNED_ID
                ? await DataManager().client.post(
                      Strings.HttpApis.OPENING_INFO,
                      headers: {
                        Strings.HttpApis.HEADER_NAME_CONTENT_TYPE:
                            Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE
                      },
                      body: openingInfoToJson(openingInfo),
                    )
                : await DataManager().client.put(
                      Strings.HttpApis.oiByIdURI(openingInfo.id),
                      headers: {
                        Strings.HttpApis.HEADER_NAME_CONTENT_TYPE:
                            Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE
                      },
                      body: openingInfoToJson(openingInfo),
                    );

        var decodedOpeningInfoResponse =
            HttpDecoder.utf8Response(openingInfoResponse);
        print('Response: $decodedOpeningInfoResponse');
      } catch (e) {
        print(e);
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

  void setBusinessDayStart(String businessDayStart) {
    openingInfo.businessDayStart = businessDayStart;
    _openingInfoSubject.add(openingInfo);
  }

  void setBusinessDayEnd(String businessDayEnd) {
    openingInfo.businessDayEnd = businessDayEnd;
    _openingInfoSubject.add(openingInfo);
  }

  void setOpeningHoursStart(BuildContext context) async {
    List<String> timeString = openingInfo.openingHoursStart.split(":");
    TimeOfDay timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(timeString.first),
        minute: int.parse(timeString.last),
      ),
    );

    openingInfo.openingHoursStart =
        sprintf('%02d:%02d', [timeOfDay.hour, timeOfDay.minute]);
    _openingInfoSubject.add(openingInfo);
  }

  void setOpeningHoursEnd(BuildContext context) async {
    List<String> timeString = openingInfo.openingHoursEnd.split(":");
    TimeOfDay timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(timeString.first),
        minute: int.parse(timeString.last),
      ),
    );

    openingInfo.openingHoursEnd =
        sprintf('%02d:%02d', [timeOfDay.hour, timeOfDay.minute]);
    _openingInfoSubject.add(openingInfo);
  }

  void dispose() {
    _facilitySubject.close();
    _openingInfoSubject.close();
  }
}
