import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:holinoti_admin/bloc/facility_input_bloc.dart';
import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/constants/themes.dart' as Themes;
import 'package:holinoti_admin/data/facility.dart';
import 'package:holinoti_admin/screens/widgets/facility/select_address.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class InputCard extends StatelessWidget {
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
                    src: Strings.HttpApis.kakaoMapWebViewURI(
                        facility.x, facility.y),
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
              child: Text("이미지 업로드"),
              onPressed: () async => _facilityInputBloc.images.addAll(
                await MultiImagePicker.pickImages(
                  maxImages: 10,
                  enableCamera: true,
                  cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
                  materialOptions: MaterialOptions(
                    statusBarColor: Themes.Colors.STATUS_BAR,
                    actionBarColor: Themes.Colors.ACTION_BAR,
                    actionBarTitleColor: Themes.Colors.ACTION_BAR_TITLE,
                    allViewTitle: "전체",
                    actionBarTitle: "업로드 할 사진 선택",
                    useDetailsView: false,
                    selectCircleStrokeColor: "#000000",
                  ),
                ),
              ),
            ),
          ),
        ]));
  }
}
