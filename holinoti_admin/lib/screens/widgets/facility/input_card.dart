import 'dart:io';

import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holinoti_admin/bloc/facility_input_bloc.dart';

class InputCard extends StatelessWidget {
  File _image;
  final FacilityInputBloc _facilityInputBloc;

  InputCard(this._facilityInputBloc);

  @override
  Widget build(BuildContext context) => Card(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
            Text("가게 정보 등록 페이지"),
            TextField(
              decoration: InputDecoration(
                labelText: "가게 이름",
              ),
              controller:
                  TextEditingController(text: _facilityInputBloc.facility.name),
              onChanged: _facilityInputBloc.setFacilityName,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "소개",
              ),
              controller: TextEditingController(
                  text: _facilityInputBloc.facility.comment),
              onChanged: _facilityInputBloc.setFacilityComment,
            ),
            Container(
              margin: const EdgeInsets.all(10),
              width: 300,
              height: 300,
              child: EasyWebView(
                src:
                    "http://holinoti.tk:8080/holinoti/kakao_map/x=${_facilityInputBloc.facility.x}/y=${_facilityInputBloc.facility.y}/",
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "가게 주소",
              ),
              controller: TextEditingController(
                  text: _facilityInputBloc.facility.address),
              onChanged: _facilityInputBloc.setFacilityAddress,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "가게 사이트 주소",
              ),
              controller: TextEditingController(
                  text: _facilityInputBloc.facility.siteUrl),
              onChanged: _facilityInputBloc.setFacilitySiteUrl,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "가게 연락처",
              ),
              controller: TextEditingController(
                  text: _facilityInputBloc.facility.phoneNumber),
              onChanged: _facilityInputBloc.setFacilityPhoneNumber,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "영업 시간",
              ),
              controller: TextEditingController(
                  text: _facilityInputBloc.facility.openingInfo),
              onChanged: _facilityInputBloc.setOpeningInfo,
            ),
            Container(
              margin: const EdgeInsets.all(10),
              width: 200,
              height: 200,
              child: (_image != null) ? Image.file(_image) : Placeholder(),
            ),
          ]));
}
