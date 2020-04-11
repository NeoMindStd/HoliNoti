import 'package:flutter/material.dart';
import 'package:holinoti_customer/bloc/facility_bloc.dart';
import 'package:holinoti_customer/data/opening_info.dart';
import 'package:holinoti_customer/screens/widgets/global/center_card.dart';
import 'package:holinoti_customer/screens/widgets/global/lower_half.dart';
import 'package:holinoti_customer/screens/widgets/global/upper_half.dart';

class FacilityPage extends StatelessWidget {
  final FacilityBloc _facilityBloc;

  FacilityPage(this._facilityBloc);

  @override
  Widget build(BuildContext context) {
    final AppBar appbar = AppBar(
      title: const Text('고객용 UI 예시'),
    );

    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            LowerHalf(
              appBarHeight: appbar.preferredSize.height,
            ),
            UpperHalf(
              appBarHeight: appbar.preferredSize.height,
            ),
            CenterCard(
              appBarHeight: appbar.preferredSize.height,
              child: Column(
                children: <Widget>[
                  Text('이름: ${_facilityBloc.facility.name}'),
                  Text('주소: ${_facilityBloc.facility.address}'),
                  Text("전화번호: ${_facilityBloc.facility.phoneNumber}"),
                  Text("사이트 주소: ${_facilityBloc.facility.siteUrl}"),
                  Text("소개: ${_facilityBloc.facility.comment}"),
                  FutureBuilder<List<OpeningInfo>>(
                      initialData: [],
                      future: _facilityBloc.requestOpeningInfo(),
                      builder: (context, snapshot) {
                        print('test-${snapshot.data}');
                        if (snapshot.data == null) return null;
                        List<Widget> ol = [];
                        for (OpeningInfo openingInfo in snapshot.data) {
                          print('test-$openingInfo');
                          ol.add(
                            Row(
                              children: <Widget>[
                                Text("영업일: "),
                                Text("${openingInfo.businessDayStart}"),
                                Text("~"),
                                Text("${openingInfo.businessDayEnd}"),
                              ],
                            ),
                          );
                          ol.add(
                            Row(
                              children: <Widget>[
                                Text("영업시간: "),
                                Text("${openingInfo.openingHoursStart}"),
                                Text("~"),
                                Text("${openingInfo.openingHoursEnd}"),
                              ],
                            ),
                          );
                        }
                        return ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: ol,
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
