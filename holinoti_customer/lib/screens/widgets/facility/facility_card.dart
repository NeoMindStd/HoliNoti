import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holinoti_customer/bloc/facility_bloc.dart';
import 'package:holinoti_customer/data/facility.dart';

class IconTextTile extends StatelessWidget {
  final IconData iconData;
  final String text;

  IconTextTile(this.iconData, this.text);

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.only(left: 10),
    child: Row(
      children: <Widget>[
        Icon(iconData),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 5),
            child: Text(
              text,
            ),
          ),
        ),
      ],
    ),
  );
}

class FacilityCard extends StatelessWidget {
  File _image;
  final FacilityBloc _facilityBloc;

  FacilityCard(this._facilityBloc);

  @override
  Widget build(BuildContext context) => Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            _facilityBloc.facility.name,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconTextTile(
            Icons.comment,
            _facilityBloc.facility.comment,
          ),
          Container(
            margin: const EdgeInsets.all(10),
            width: 300,
            height: 300,
            child: (_image != null) ? Image.file(_image) : Placeholder(),
          ),
          IconTextTile(
            Icons.location_on,
            _facilityBloc.facility.address,
          ),
          IconTextTile(
            Icons.public,
            _facilityBloc.facility.siteUrl,
          ),
          IconTextTile(
            Icons.phone,
            _facilityBloc.facility.phoneNumber,
          ),
          IconTextTile(
              Icons.access_time,
              _facilityBloc.facility.openingInfo.length > 0
                  ? "영업일: ${_facilityBloc.facility.openingInfo.first.businessDayStart} ~ "
                  "${_facilityBloc.facility.openingInfo.first.businessDayEnd}\n"
                  "영업시간: ${_facilityBloc.facility.openingInfo.first.openingHoursStart} ~ "
                  "${_facilityBloc.facility.openingInfo.first.openingHoursEnd}"
                  : "영업시간 정보 없음"),
          Container(
            margin: const EdgeInsets.all(10),
            width: 200,
            height: 200,
            child: (_image != null) ? Image.file(_image) : Placeholder(),
          ),
        ],
      ));
}
