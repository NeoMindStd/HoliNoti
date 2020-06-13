import 'dart:io';

import 'package:holinoti_customer/constants/enums.dart' as Enums;
import 'package:holinoti_customer/constants/nos.dart' as Nos;
import 'package:holinoti_customer/constants/strings.dart' as Strings;
import 'package:holinoti_customer/data/facility.dart';
import 'package:holinoti_customer/data/facility_image.dart';
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

  void addFacilityImage(Facility facility, FacilityImage facilityImage) {
    if (facility.facilityImages == null) facility.facilityImages = [];
    facility.facilityImages.add(facilityImage);
    _facilitiesSubject.add(DataManager().facilities);
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
    print("relationAFsResponse.statusCode: ${relationAFsResponse.statusCode}");
    if (relationAFsResponse.statusCode == HttpStatus.created) {
      RelationAF response =
          RelationAF.fromJson(HttpDecoder.utf8Response(relationAFsResponse));
      DataManager().addRelationAF(response);
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

  Future queryFacilities({int distance = 5000}) async {
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
          .map(
            (relationAFMap) {
              RelationAF relationAF = RelationAF.fromJson(relationAFMap);
              print("decoded: $relationAF");
              return relationAF;
            },
          )
          .where((relationAF) => relationAF.role != Enums.Role.customer)
          .toList();
      print("relationAFs: ${DataManager().relationAFs}");
      List decodedFacilitiesResponse = [];

      for (RelationAF relationAF in DataManager().relationAFs) {
        http.Response facilityResponse = await DataManager().client.get(
          Strings.HttpApis.facilityByCodeURI(relationAF.facilityCode),
          headers: {
            Strings.HttpApis.HEADER_NAME_CONTENT_TYPE:
                Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE_JSON
          },
        );
        decodedFacilitiesResponse
            .add(HttpDecoder.utf8Response(facilityResponse));
      }

      print(decodedFacilitiesResponse);

      DataManager().facilities = [];
      for (var facilityResponse in decodedFacilitiesResponse) {
        try {
          DataManager().addFacility(Facility.fromJson(facilityResponse));
        } catch (e) {}
      }
      DataManager().dataBloc.setUser(DataManager().currentUser);

      print('Facilities: ${DataManager().facilities}');
    } else {
      await DataManager().queryPosition();
      print("========Search========");
      print("${DataManager().currentPosition}, Distance: $distance");
      print("=====================");
      http.Response facilitiesResponse;
      if (distance > Nos.Global.WITHOUT_DISTANCE) {
        facilitiesResponse = await http.get(
          Strings.HttpApis.facilitiesByCoordinates(
              DataManager().currentPosition.longitude,
              DataManager().currentPosition.latitude,
              distance),
          headers: {
            Strings.HttpApis.HEADER_NAME_CONTENT_TYPE:
                Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE_JSON
          },
        );
      } else {
        facilitiesResponse = await http.get(
          Strings.HttpApis.facilitiesURI(),
          headers: {
            Strings.HttpApis.HEADER_NAME_CONTENT_TYPE:
                Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE_JSON
          },
        );
      }
      var decodedFacilitiesResponse =
          HttpDecoder.utf8Response(facilitiesResponse);
      print(decodedFacilitiesResponse);
      DataManager().facilities = [];
      for (var facilityResponse in decodedFacilitiesResponse) {
        try {
          DataManager().addFacility(Facility.fromJson(facilityResponse));
        } catch (e) {
          print(e);
        }
      }
      print("queryByPosition: ${DataManager().facilities}");
    }
    queryFacilityImages();
  }

  Future queryFacilityImages() async {
    DataManager().facilities.forEach((facility) async {
      http.Response imagesResponse = await http.get(
        Strings.HttpApis.fIMGsByFCodeURI(facility.code),
        headers: {
          Strings.HttpApis.HEADER_NAME_CONTENT_TYPE:
              Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE_JSON
        },
      );

      for (var imageResponse in HttpDecoder.utf8Response(imagesResponse)) {
        addFacilityImage(facility, FacilityImage.fromJson(imageResponse));
      }
      print(imagesResponse.statusCode);
      print(facility.facilityImages);
    });
  }

  void dispose() {
    _currentUserSubject.close();
    _facilitiesSubject.close();
    _relationAFsSubject.close();
  }
}
