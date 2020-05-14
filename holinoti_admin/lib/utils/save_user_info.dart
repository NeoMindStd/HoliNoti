import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:flutter/material.dart';
import 'package:holinoti_admin/data/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SaveUserInfo{

  Future read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key));
  }

  Future save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  Future remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

}