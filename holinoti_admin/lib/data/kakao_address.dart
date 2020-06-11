import 'dart:convert';

class KakaoAddress {
  String addressName;
  String buildingName;
  String zoneNo;
  double x;
  double y;

  KakaoAddress({
    this.addressName = "",
    this.buildingName = "",
    this.zoneNo = "",
    this.x = 0,
    this.y = 0,
  });

  factory KakaoAddress.fromJson(Map<String, dynamic> json) => KakaoAddress(
        addressName: json['address_name'] as String ?? "",
        buildingName: json['building_name'] as String ?? "",
        zoneNo: json["zone_no"] as String ?? "",
        x: double.parse(json['x'] as String) ?? 0,
        y: double.parse(json['y'] as String) ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'address_name': addressName,
        'building_name': buildingName,
        "zone_no": zoneNo,
        'x': x,
        'y': y,
      };

  @override
  String toString() =>
      'address{addressName: $addressName, buildingName: $buildingName, zoneNo: $zoneNo, x: $x, y: $y}';
}

KakaoAddress addressFromJson(String string) =>
    KakaoAddress.fromJson(json.decode(string));

String addressToJson(KakaoAddress address) => json.encode(address.toJson());
