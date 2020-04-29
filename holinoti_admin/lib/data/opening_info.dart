import 'dart:convert';

import 'package:holinoti_admin/constants/nos.dart' as Nos;
import 'package:holinoti_admin/constants/strings.dart' as Strings;

class OpeningInfo {
  int id;
  int facilityCode;
  String businessDayStart;
  String openingHoursStart;
  String businessDayEnd;
  String openingHoursEnd;

  OpeningInfo(
      {this.id = Nos.Global.NOT_ASSIGNED_ID,
      this.facilityCode = Nos.Global.NOT_ASSIGNED_ID,
      this.businessDayStart,
      this.openingHoursStart = "09:00",
      this.businessDayEnd,
      this.openingHoursEnd = "21:00"}) {
    businessDayStart ??= Strings.RegisterFacilityPage.DAYS_OF_THE_WEEKS.first;
    businessDayEnd ??= Strings.RegisterFacilityPage.DAYS_OF_THE_WEEKS.last;
  }

  factory OpeningInfo.fromJson(Map<String, dynamic> json) => OpeningInfo(
        id: json['id'] as int,
        facilityCode: json['facilityCode'] as int,
        businessDayStart: json['businessDayStart'] as String,
        openingHoursStart: json['openingHoursStart'] as String,
        businessDayEnd: json['businessDayEnd'] as String,
        openingHoursEnd: json['openingHoursEnd'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'facilityCode': facilityCode,
        'businessDayStart': businessDayStart,
        'openingHoursStart': openingHoursStart,
        'businessDayEnd': businessDayEnd,
        'openingHoursEnd': openingHoursEnd,
      };

  @override
  String toString() =>
      'OpeningInfo{id: $id, facilityCode: $facilityCode, businessDayStart: $businessDayStart, openingHoursStart: $openingHoursStart, businessDayEnd: $businessDayEnd, openingHoursEnd: $openingHoursEnd}';
}

OpeningInfo openingInfoFromJson(String string) =>
    OpeningInfo.fromJson(json.decode(string));

String openingInfoToJson(OpeningInfo openingInfo) =>
    json.encode(openingInfo.toJson());
