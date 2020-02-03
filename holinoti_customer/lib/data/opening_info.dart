import 'dart:convert';
import 'package:holinoti_customer/constants/enums.dart' as Enums;
import 'package:holinoti_customer/constants/strings.dart' as Strings;

class OpeningInfo {
  int id;
  int facilityCode;
  String businessDayStart;
  String openingHoursStart;
  String businessDayEnd;
  String openingHoursEnd;

  OpeningInfo({
    this.id = -1,
    this.facilityCode = -1,
    this.businessDayStart,
    this.openingHoursStart = "09:00",
    this.businessDayEnd,
    this.openingHoursEnd = "21:00"
  }) {
    businessDayStart ??= Strings.GlobalPage.DAYS_OF_THE_WEEKS.first;
    businessDayEnd ??= Strings.GlobalPage.DAYS_OF_THE_WEEKS.last;
  }


  factory OpeningInfo.fromJson(Map<String, dynamic> json) =>
      OpeningInfo(
        id: json['id'] as int,
        facilityCode: json['facilityCode'] as int,
        businessDayStart: json['businessDayStart'] as String,
        openingHoursStart: json['openingHoursStart'] as String,
        businessDayEnd: json['businessDayEnd'] as String,
        openingHoursEnd: json['openingHoursEnd'] as String,
      );


  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'facilityCode': facilityCode,
        'businessDayStart': businessDayStart,
        'openingHoursStart': openingHoursStart,
        'businessDayEnd': businessDayEnd,
        'openingHoursEnd': openingHoursEnd,
      };

  @override
  String toString() {
    return 'OpeningInfo{id: $id, facilityCode: $facilityCode, businessDayStart: $businessDayStart, openingHoursStart: $openingHoursStart, businessDayEnd: $businessDayEnd, openingHoursEnd: $openingHoursEnd}';
  }
}


OpeningInfo openingInfoFromJson(String string) => OpeningInfo.fromJson(json.decode(string));

String openingInfoToJson(OpeningInfo openingInfo) => json.encode(openingInfo.toJson());