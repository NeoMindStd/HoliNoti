import 'dart:convert';

import 'package:holinoti_admin/data/opening_info.dart';

class Facility {
  int code;
  String name;
  String address;

  /// json 매핑시 제외
  List<OpeningInfo> openingInfo;

  Facility({
    this.code = -1,
    this.name = "",
    this.address = "",
    this.openingInfo,
  }) {
    openingInfo ??= [];
  }

  factory Facility.fromJson(Map<String, dynamic> json) => Facility(
        code: json['code'] as int,
        name: json['name'] as String,
        address: json['address'] as String,
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        'address': address,
      };

  @override
  String toString() {
    return 'Facility{code: $code, name: $name, address: $address}';
  }
}

Facility facilityFromJson(String string) =>
    Facility.fromJson(json.decode(string));

String facilityToJson(Facility facility) => json.encode(facility.toJson());
