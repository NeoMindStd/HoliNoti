import 'dart:io';

import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holinoti_admin/bloc/facility_bloc.dart';
import 'package:holinoti_admin/data/facility.dart';

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
          child: StreamBuilder<Facility>(
        initialData: _facilityBloc.facility,
        stream: _facilityBloc.facilityStream,
        builder: (context, snapshot) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              snapshot.data.name,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconTextTile(
              Icons.comment,
              snapshot.data.comment,
            ),
            Container(
              margin: const EdgeInsets.all(10),
              width: 300,
              height: 300,
              child: EasyWebView(
                src:
                    "http://holinoti.tk:8080/holinoti/kakao_map/x=${_facilityBloc.facility.x}/y=${_facilityBloc.facility.y}/",
              ),
            ),
            IconTextTile(
              Icons.location_on,
              snapshot.data.address,
            ),
            IconTextTile(
              Icons.public,
              snapshot.data.siteUrl,
            ),
            IconTextTile(
              Icons.phone,
              snapshot.data.phoneNumber,
            ),
            IconTextTile(
                Icons.access_time,
                snapshot.data.openingInfo.length > 0
                    ? "영업일: ${snapshot.data.openingInfo.first.businessDayStart} ~ "
                        "${snapshot.data.openingInfo.first.businessDayEnd}\n"
                        "영업시간: ${snapshot.data.openingInfo.first.openingHoursStart} ~ "
                        "${snapshot.data.openingInfo.first.openingHoursEnd}"
                    : "영업시간 정보 없음"),
            Container(
              margin: const EdgeInsets.all(10),
              width: 200,
              height: 200,
              child: (_image != null) ? Image.file(_image) : Placeholder(),
            ),
          ],
        ),
      ));
}
