import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holinoti_admin/data/facility.dart';
import 'package:holinoti_admin/data/manager.dart';
import 'package:holinoti_admin/data/opening_info.dart';
import 'package:holinoti_admin/utils/data_manager.dart';
import 'package:holinoti_admin/utils/http_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:sprintf/sprintf.dart';

class RegisterFacilityBloc {
  Facility facility;
  OpeningInfo openingInfo;


  RegisterFacilityBloc() {
    facility = Facility();
    openingInfo = OpeningInfo();
  }

  // TODO 이미 시설이 있는경우 등록하지 않게 해야함
  void registerFacility(
      BuildContext context, String name, String address) async {
    try {
      http.Response facilityResponse = await http.post(
        "http://holinoti.tk:8080/holinoti/facilities",
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: facilityToJson(facility),
      );

      var decodedFacilityResponse = HttpDecoder.utf8Response(facilityResponse);
      print('Response: $decodedFacilityResponse');

      DataManager().signedIn.facility =
          Facility.fromJson(decodedFacilityResponse);
      print('Added: ${DataManager().signedIn.facility}');

      openingInfo.facilityCode = DataManager().signedIn.facilityCode;
      try {
        http.Response openingInfoResponse = await http.post(
          "http://holinoti.tk:8080/holinoti/opening-infos",
          headers: {"Content-Type": "application/json; charset=utf-8"},
          body: openingInfoToJson(openingInfo),
        );

        var decodedOpeningInfoResponse =
            HttpDecoder.utf8Response(openingInfoResponse);
        print('Response: $decodedOpeningInfoResponse');
      } catch (e) {
        print(e);
      }

      try {
        await http.put(
          "http://holinoti.tk:8080/holinoti/managers/id=${DataManager().signedIn.id}",
          headers: {"Content-Type": "application/json; charset=utf-8"},
          body: managerToJson(DataManager().signedIn),
        );

        print(managerToJson(DataManager().signedIn));
        print('Updated: ${DataManager().signedIn}');
      } catch (e) {
        print(e);
      }
    } catch (e) {
      print(e);
    }
    Navigator.pop(context);
  }

  final _facilitySubject = PublishSubject<Facility>();
  get facilityStream => _facilitySubject.stream;

  void setFacilityName(String name) {
    facility.name = name;
    _facilitySubject.add(facility);
  }

  void setFacilityAddress(String address) {
    facility.address = address;
    _facilitySubject.add(facility);
  }

  final _openingInfoSubject = PublishSubject<OpeningInfo>();
  get openingInfoStream => _openingInfoSubject.stream;

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
