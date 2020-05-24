import 'dart:io';
import 'dart:async';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holinoti_admin/bloc/facility_input_bloc.dart';
import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/data/opening_info.dart';


class InputCard extends StatelessWidget {
  File _image;
  final FacilityInputBloc _facilityInputBloc;

  InputCard(this._facilityInputBloc);

  @override
  Widget build(BuildContext context) => Card(
      child:
      Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
          Widget>[
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
          controller:
          TextEditingController(text: _facilityInputBloc.facility.comment),
          onChanged: _facilityInputBloc.setFacilityComment,
        ),
        Container(
          margin: const EdgeInsets.all(10),
          width: 300,
          height: 300,
          child: (_image != null) ? Image.file(_image) : Placeholder(),
        ),
        TextField(
          decoration: InputDecoration(
            labelText: "가게 주소",
          ),
          controller:
          TextEditingController(text: _facilityInputBloc.facility.address),
          onChanged: _facilityInputBloc.setFacilityAddress,
        ),
        TextField(
          decoration: InputDecoration(
            labelText: "가게 사이트 주소",
          ),
          controller:
              TextEditingController(text: _facilityInputBloc.facility.siteUrl),
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
        Row(
          children: <Widget>[
            Text("영업일: "),
            StreamBuilder<OpeningInfo>(
              initialData: _facilityInputBloc.openingInfo,
              stream: _facilityInputBloc.openingInfoStream,
              builder: (context, snapshot) => SizedBox(
                width: 100.0,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    value: snapshot.data.businessDayStart,
                    items: Strings.RegisterFacilityPage.DAYS_OF_THE_WEEKS
                        .map(
                          (String value) => DropdownMenuItem<String>(
                            value: value,
                            child: SizedBox(
                              width: double.infinity,
                              child: Text(
                                value,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: _facilityInputBloc.setBusinessDayStart,
                  ),
                ),
              ),
            ),
            Text("~"),
            StreamBuilder<OpeningInfo>(
              initialData: _facilityInputBloc.openingInfo,
              stream: _facilityInputBloc.openingInfoStream,
              builder: (context, snapshot) => SizedBox(
                width: 100.0,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    value: snapshot.data.businessDayEnd,
                    items: Strings.RegisterFacilityPage.DAYS_OF_THE_WEEKS
                        .map(
                          (String value) => DropdownMenuItem<String>(
                            value: value,
                            child: SizedBox(
                              width: double.infinity,
                              child: Text(
                                value,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: _facilityInputBloc.setBusinessDayEnd,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text("영업시간: "),
            StreamBuilder<OpeningInfo>(
              initialData: _facilityInputBloc.openingInfo,
              stream: _facilityInputBloc.openingInfoStream,
              builder: (context, snapshot) => SizedBox(
                width: 80,
                height: 30,
                child: InkWell(
                  child: Center(child: Text(snapshot.data.openingHoursStart)),
                  onTap: () => _facilityInputBloc.setOpeningHoursStart(context),
                ),
              ),
            ),
            Text("~"),
            StreamBuilder<OpeningInfo>(
              initialData: _facilityInputBloc.openingInfo,
              stream: _facilityInputBloc.openingInfoStream,
              builder: (context, snapshot) => SizedBox(
                width: 80,
                height: 30,
                child: InkWell(
                  child: Center(child: Text(snapshot.data.openingHoursEnd)),
                  onTap: () => _facilityInputBloc.setOpeningHoursEnd(context),
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.all(10),
          width: 200,
          height: 200,
          child: (_image != null) ? Image.file(_image) : Placeholder(),
        ),
      ]));
}
