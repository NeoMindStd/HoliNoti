import 'dart:convert';

import 'package:holinoti_admin/constants/enums.dart' as Enums;

class RelationAF {
  int id;
  int userId;
  int facilityCode;
  Enums.Role role;

  RelationAF({
    this.id = -1,
    this.userId,
    this.facilityCode,
    this.role,
  });

  factory RelationAF.fromJson(Map<String, dynamic> json) => RelationAF(
        id: json['id'] as int,
        userId: json['userId'] as int,
        facilityCode: json['facilityCode'] as int,
        role: json['role'] as Enums.Role,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'facilityCode': facilityCode,
        'role': Enums.toString(role),
      };

  @override
  String toString() =>
      'RelationAF{id: $id, userId: $userId, facilityCode: $facilityCode, role: $role}';
}

RelationAF relationAFFromJson(String string) =>
    RelationAF.fromJson(json.decode(string));

String relationAFToJson(RelationAF relationAF) =>
    json.encode(relationAF.toJson());
