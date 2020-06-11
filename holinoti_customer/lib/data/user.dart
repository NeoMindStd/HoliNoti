import 'dart:convert';

import 'package:holinoti_customer/constants/enums.dart' as Enums;
import 'package:holinoti_customer/constants/nos.dart' as Nos;

class User {
  int id;
  String account;
  String password;
  String name;
  Enums.Authority authority;
  String email;
  String phoneNumber;
  String deviceToken;

  User(
      {this.id = Nos.Global.NOT_ASSIGNED_ID,
      this.account,
      this.password,
      this.name = "",
      this.authority,
      this.email = "",
      this.phoneNumber = "",
      this.deviceToken = ""});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int ?? Nos.Global.NOT_ASSIGNED_ID,
        account: json['account'] as String ?? "",
        password: json['password'] as String ?? "",
        name: json['name'] as String ?? "",
        authority:
            json['authority'] as Enums.Authority ?? Enums.Authority.normal,
        email: json['email'] as String ?? "",
        phoneNumber: json['phoneNumber'] as String ?? "",
        deviceToken: json['deviceToken'] as String ?? "",
      );

  Map<String, dynamic> toJsonWithoutPassword() => {
        'id': id,
        'account': account,
        'name': name,
        'authority': Enums.toString(authority),
        'email': email,
        'phoneNumber': phoneNumber,
        'deviceToken': deviceToken,
      };

  Map<String, dynamic> toJson() {
    var jsonWithoutPassword = toJsonWithoutPassword();
    jsonWithoutPassword['password'] = password;
    return jsonWithoutPassword;
  }

  @override
  String toString() =>
      'User{id: $id, account: $account, name: $name, authority: $authority, email: $email, phoneNumber: $phoneNumber, deviceToken: $deviceToken}';
}

User userFromJson(String string) => User.fromJson(json.decode(string));

String userToJsonWithoutPassword(User user) =>
    json.encode(user.toJsonWithoutPassword());
String userToJson(User user) => json.encode(user.toJson());
