import 'dart:io';

import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:holinoti_customer/bloc/facility_bloc.dart';

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

// ignore: must_be_immutable
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
            child: EasyWebView(
              src:
                  "http://holinoti.tk:8080/holinoti/kakao_map/x=${_facilityBloc.facility.x}/y=${_facilityBloc.facility.y}/",
            ),
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
                  ? "영업 시간: ${_facilityBloc.facility.openingInfo}"
                  : "영업시간 정보 없음"),
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
      ));
}
