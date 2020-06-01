import 'dart:io';

import 'package:holinoti_admin/constants/enums.dart' as Enums;
import 'package:holinoti_admin/constants/nos.dart' as Nos;
import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/data/facility.dart';
import 'package:holinoti_admin/data/relation_af.dart';
import 'package:holinoti_admin/data/user.dart';
import 'package:holinoti_admin/utils/data_manager.dart';
import 'package:holinoti_admin/utils/http_decoder.dart';
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
                Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE_JSON
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
            Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE_JSON
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

  Future queryFacilities() async {
    /*************************************************************************
     *                           Get Bookmark List                           *
     * Exclude if relationAF.role is Enums.Role.customer                     *
     *************************************************************************/
    if (DataManager().currentUser != null &&
        DataManager().currentUser.id != Nos.Global.NOT_ASSIGNED_ID) {
      http.Response relationAFsResponse = await DataManager().client.get(
        Strings.HttpApis.relationAFsByUIdURI(DataManager().currentUser.id),
        headers: {
          Strings.HttpApis.HEADER_NAME_CONTENT_TYPE:
              Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE_JSON
        },
      );

      if (relationAFsResponse.statusCode != HttpStatus.ok) return;

      List decodedRelationAFResponse =
          HttpDecoder.utf8Response(relationAFsResponse);
      print('decodedRelationAFResponse: $decodedRelationAFResponse');

      DataManager().relationAFs = decodedRelationAFResponse
          .map((relationAFMap) {
            relationAFMap['role'] =
                Enums.fromString(Enums.Role.values, relationAFMap['role']);
            return RelationAF.fromJson(relationAFMap);
          })
          .where((relationAF) => relationAF.role != Enums.Role.customer)
          .toList();
      List decodedFacilitiesResponse = [];

      for (RelationAF relationAF in DataManager().relationAFs) {
        decodedFacilitiesResponse
            .add(HttpDecoder.utf8Response(await DataManager().client.get(
          Strings.HttpApis.facilityByCodeURI(relationAF.facilityCode),
          headers: {
            Strings.HttpApis.HEADER_NAME_CONTENT_TYPE:
                Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE_JSON
          },
        )));
      }

      print(decodedFacilitiesResponse);

      List<Facility> facilities = [];
      for (var facilityResponse in decodedFacilitiesResponse) {
        try {
          facilities.add(Facility.fromJson(facilityResponse));
        } catch (e) {}
      }
      DataManager().facilities = facilities;
      DataManager().dataBloc.setUser(DataManager().currentUser);

      print('Facilities: ${DataManager().facilities}');
    } else {
      await DataManager().queryPosition();
      print("========Where========");
      print(DataManager().currentPosition);
      print("====================");
      http.Response facilitiesResponse = await http.get(
        Strings.HttpApis.facilitiesByCoordinates(
            DataManager().currentPosition.longitude,
            DataManager().currentPosition.latitude,
            500),
        headers: {
          Strings.HttpApis.HEADER_NAME_CONTENT_TYPE:
              Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE_JSON
        },
      );
      var decodedFacilitiesResponse =
          HttpDecoder.utf8Response(facilitiesResponse);
      print(decodedFacilitiesResponse);
      for (var facilityResponse in decodedFacilitiesResponse) {
        try {
          DataManager().addFacility(Facility.fromJson(facilityResponse));
        } catch (e) {
          print(e);
        }
      }
      print("queryByPosition: ${DataManager().facilities}");
    }
  }

  void dispose() {
    _currentUserSubject.close();
    _facilitiesSubject.close();
  }
}
