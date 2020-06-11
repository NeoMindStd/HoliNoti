import 'dart:convert';

import 'package:holinoti_customer/constants/enums.dart' as Enums;
import 'package:holinoti_customer/constants/nos.dart' as Nos;

class RelationAF {
  int id;
  int userId;
  int facilityCode;
  Enums.Role role;

  RelationAF({
    this.id = Nos.Global.NOT_ASSIGNED_ID,
    this.userId,
    this.facilityCode,
    this.role,
  });

  factory RelationAF.fromJson(Map<String, dynamic> json) => RelationAF(
        id: json['id'] as int ?? Nos.Global.NOT_ASSIGNED_ID,
        userId: json['userId'] as int ?? Nos.Global.NOT_ASSIGNED_ID,
        facilityCode: json['facilityCode'] as int ?? Nos.Global.NOT_ASSIGNED_ID,
        role: json['role'] == null
            ? Enums.fromString(Enums.Role.values, json['role'])
            : Enums.Role.customer,
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
