import 'dart:convert';

import 'package:holinoti_customer/constants/nos.dart' as Nos;
import 'package:holinoti_customer/data/facility_image.dart';

class Facility {
  int code;
  String name;
  String address;
  String phoneNumber;
  String siteUrl;
  String comment;
  String openingInfo;
  double x;
  double y;

  /// json 매핑시 제외
  List<FacilityImage> facilityImages;

  Facility({
    this.code = Nos.Global.NOT_ASSIGNED_ID,
    this.name = "",
    this.address = "",
    this.phoneNumber = "",
    this.siteUrl = "",
    this.comment = "",
    this.openingInfo = "",
    this.x = 0,
    this.y = 0,
  }) {
    facilityImages ??= [];
  }

  factory Facility.fromJson(Map<String, dynamic> json) => Facility(
        code: json['code'] as int ?? Nos.Global.NOT_ASSIGNED_ID,
        name: json['name'] as String ?? "",
        address: json['address'] as String ?? "",
        phoneNumber: json['phoneNumber'] as String ?? "",
        siteUrl: json['siteUrl'] as String ?? "",
        comment: json['comment'] as String ?? "",
        openingInfo: json['openingInfo'] as String ?? "",
        x: (((json['coordinates'] as Map) ??
                    {
                      'coordinates': [0, 0]
                    })['coordinates'] ??
                [0, 0])[0] ??
            0,
        y: (((json['coordinates'] as Map) ??
                    {
                      'coordinates': [0, 0]
                    })['coordinates'] ??
                [0, 0])[1] ??
            0,
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        'address': address,
        'phoneNumber': phoneNumber,
        'siteUrl': siteUrl,
        'comment': comment,
        'openingInfo': openingInfo,
        'coordinates': {
          "type": "Point",
          "coordinates": [
            x,
            y,
          ],
        },
      };

  @override
  String toString() =>
      'Facility{code: $code, name: $name, address: $address, phoneNumber: $phoneNumber, siteUrl: $siteUrl, comment: $comment, openingInfo: $openingInfo, x: $x, y: $y}';
}

Facility facilityFromJson(String string) =>
    Facility.fromJson(json.decode(string));

String facilityToJson(Facility facility) => json.encode(facility.toJson());
