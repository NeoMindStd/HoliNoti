import 'dart:io';

import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:holinoti_admin/bloc/facility_bloc.dart';
import 'package:holinoti_admin/constants/strings.dart' as Strings;
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
                src: Strings.HttpApis.kakaoMapWebViewURI(
                    _facilityBloc.facility.x, _facilityBloc.facility.y),
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
                _facilityBloc.facility.openingInfo.length > 0
                    ? "${Strings.GlobalPage.OPENING_INFO}: ${_facilityBloc.facility.openingInfo}"
                    : Strings.GlobalPage.OPENING_INFO_NOT_EXIST),
            Container(
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              height: 200,
              child: Swiper(
                // TODO 이미지 목록 수신 후 보여주기
                itemBuilder: (BuildContext context, int index) => Image.network(
                  "http://via.placeholder.com/350x150",
                  fit: BoxFit.fill,
                ),
                pagination: SwiperPagination(),
                control: SwiperControl(),
                itemCount: 3,
              ),
            ),
          ],
        ),
      ));
}
