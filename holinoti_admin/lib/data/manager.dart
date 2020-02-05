import 'dart:convert';

import 'package:holinoti_admin/constants/enums.dart' as Enums;
import 'package:holinoti_admin/data/facility.dart';

class Manager {
  int id;
  String account;
  String password;
  String name;
  int facilityCode;
  Enums.UserType userType;

  /// json 매핑시 제외
  Facility _facility;

  Facility get facility => _facility;

  set facility(Facility facility) {
    _facility = facility;
    facilityCode = _facility.code;
  }

  Manager({
    this.id,
    this.account,
    this.password,
    this.name,
    this.facilityCode,
    this.userType,
  });

  factory Manager.fromJson(Map<String, dynamic> json) => Manager(
        id: json['id'] as int,
        account: json['account'] as String,
        password: json['password'] as String,
        name: json['name'] as String,
        facilityCode: json['facilityCode'] as int,
        userType: json['userType'] as Enums.UserType,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'account': account,
        'password': password,
        'name': name,
        'facilityCode': facilityCode,
        'userType': userType,
      };

  @override
  String toString() {
    return 'Manager{id: $id, account: $account, name: $name, facilityCode: $facilityCode, userType: $userType, facility: $_facility}';
  }
}

Manager managerFromJson(String string) => Manager.fromJson(json.decode(string));

String managerToJson(Manager manager) => json.encode(manager.toJson());
