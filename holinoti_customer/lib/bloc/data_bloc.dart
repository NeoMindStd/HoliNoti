import 'dart:io';

import 'package:holinoti_customer/constants/Strings.dart' as Strings;
import 'package:holinoti_customer/data/facility.dart';
import 'package:holinoti_customer/data/relation_af.dart';
import 'package:holinoti_customer/data/user.dart';
import 'package:holinoti_customer/utils/data_manager.dart';
import 'package:holinoti_customer/utils/http_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class DataBloc {
  final _currentUserSubject = PublishSubject<User>();
  final _facilitiesSubject = PublishSubject<List<Facility>>();
  final _relationAFsSubject = PublishSubject<List<RelationAF>>();

  get currentUserStream => _currentUserSubject.stream;
  get facilitiesStream => _facilitiesSubject.stream;
  get relationAFsStream => _relationAFsSubject.stream;

  void setUser(User user) {
    _currentUserSubject.add(user);
  }

  void setFacilities(List<Facility> facilities) {
    _facilitiesSubject.add(facilities);
  }

  void setRelationAFs(List<RelationAF> relationAFs) {
    _relationAFsSubject.add(relationAFs);
  }

  Future addRelationAF(RelationAF relationAF) async {
    http.Response relationAFsResponse = await DataManager().client.post(
          Strings.HttpApis.relationAFURI(),
          headers: {
            Strings.HttpApis.HEADER_NAME_CONTENT_TYPE:
                Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE
          },
          body: relationAFToJson(relationAF),
        );
    if (relationAFsResponse.statusCode == HttpStatus.created) {
      RelationAF response =
          RelationAF.fromJson(HttpDecoder.utf8Response(relationAFsResponse));
      DataManager().addRelationAF(relationAF);
    } else {
      throw Exception(
          "HTTP Post Error: \nStatus Code: ${relationAFsResponse.statusCode}\nHeaders: ${relationAFsResponse.headers}\nBody: ${relationAFsResponse.body}");
    }
    _relationAFsSubject.add(DataManager().relationAFs);
  }

  Future deleteRelationAF(RelationAF relationAF) async {
    http.Response relationAFsResponse = await DataManager().client.delete(
      Strings.HttpApis.relationAFByIdURI(relationAF.id),
      headers: {
        Strings.HttpApis.HEADER_NAME_CONTENT_TYPE:
            Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE
      },
    );
    if (relationAFsResponse.statusCode == HttpStatus.ok) {
      DataManager().relationAFs.remove(relationAF);
    } else {
      throw Exception(
          "HTTP Delete Error: \nStatus Code: ${relationAFsResponse.statusCode}\nHeaders: ${relationAFsResponse.headers}\nBody: ${relationAFsResponse.body}");
    }
    _relationAFsSubject.add(DataManager().relationAFs);
  }

  void dispose() {
    _currentUserSubject.close();
    _facilitiesSubject.close();
    _relationAFsSubject.close();
  }
}
