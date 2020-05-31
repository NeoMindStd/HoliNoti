import 'dart:io';

import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:holinoti_admin/bloc/facility_input_bloc.dart';
import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/data/facility.dart';
import 'package:holinoti_admin/screens/widgets/facility/select_address.dart';

class InputCard extends StatelessWidget {
  File _image;
  final FacilityInputBloc _facilityInputBloc;

  InputCard(this._facilityInputBloc);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
          Text("가게 정보 등록 페이지"),
          TextFormField(
            decoration: InputDecoration(
              labelText: "가게 이름",
            ),
            controller: _facilityInputBloc.nameController,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: "소개",
            ),
            controller: _facilityInputBloc.commentController,
          ),
          StreamBuilder<Facility>(
              initialData: _facilityInputBloc.facility,
              stream: _facilityInputBloc.facilityStream,
              builder: (context, snapshot) {
                assert(snapshot != null && snapshot.data != null);
                Facility facility = snapshot.data;
                return Container(
                  margin: const EdgeInsets.all(10),
                  width: 300,
                  height: 300,
                  child: EasyWebView(
                    src:
                        "http://holinoti.tk:8080/holinoti/kakao_map/x=${facility.x}/y=${facility.y}/",
                  ),
                );
              }),
          InkWell(
            child: Text("가게 주소"),
            onTap: () => Navigator.push(
              context,
              platformPageRoute(
                context: context,
                builder: (context) => SelectAddress(_facilityInputBloc),
              ),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: "가게 사이트 주소",
            ),
            controller: _facilityInputBloc.urlController,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: "가게 연락처",
            ),
            controller: _facilityInputBloc.phoneNumberController,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: "영업 시간",
            ),
            controller: _facilityInputBloc.openingInfoController,
          ),
          Container(
            margin: const EdgeInsets.all(10),
            width: 200,
            height: 200,
            child: MaterialButton(
              child: Image.asset(Strings.Assets.RESTAURANT_JPG),
              onPressed: () {}, // TODO 이미지 관리 화면으로 전환
            ),
          ),
        ]));
  }
}
