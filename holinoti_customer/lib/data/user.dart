import 'dart:convert';

import 'package:holinoti_customer/constants/enums.dart' as Enums;
import 'package:holinoti_customer/data/facility.dart';
import 'package:holinoti_customer/constants/nos.dart' as Nos;

class User {
  int id;
  String account;
  String password;
  String name;
  Enums.Authority authority;
  String email;
  String phoneNumber;

  /// json 매핑시 제외
  List<Facility> facilities;

  User(
      {this.id = Nos.Global.NOT_ASSIGNED_ID,
      this.account,
      this.password,
      this.name = "",
      this.authority,
      this.email = "",
      this.phoneNumber = ""}) {
    facilities ??= [];
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int,
        account: json['account'] as String,
        password: json['password'] as String,
        name: json['name'] as String,
        authority: json['authority'] as Enums.Authority,
        email: json['email'] as String,
        phoneNumber: json['phoneNumber'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'account': account,
        'password': password,
        'name': name,
        'authority': Enums.toString(authority),
        'email': email,
        'phoneNumber': phoneNumber,
      };

  @override
  String toString() =>
      'User{id: $id, account: $account, name: $name, authority: $authority, email: $email, phoneNumber: $phoneNumber}';
}

User userFromJson(String string) => User.fromJson(json.decode(string));

String userToJson(User user) => json.encode(user.toJson());
