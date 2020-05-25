import 'dart:convert';

import 'package:holinoti_customer/constants/nos.dart' as Nos;

class FacilityImage {
  int id;
  String path;
  int facilityCode;

  FacilityImage({
    this.id = Nos.Global.NOT_ASSIGNED_ID,
    this.path,
    this.facilityCode,
  });

  factory FacilityImage.fromJson(Map<String, dynamic> json) => FacilityImage(
        id: json['id'] as int ?? Nos.Global.NOT_ASSIGNED_ID,
        path: json['path'] as String ?? "",
        facilityCode: json['facilityCode'] as int ?? Nos.Global.NOT_ASSIGNED_ID,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'path': path,
        'facilityCode': facilityCode,
      };

  @override
  String toString() =>
      'FacilityImage{id: $id, path: $path, facilityCode: $facilityCode}';
}

FacilityImage facilityImageFromJson(String string) =>
    FacilityImage.fromJson(json.decode(string));

String facilityImageToJson(FacilityImage facilityImage) =>
    json.encode(facilityImage.toJson());
