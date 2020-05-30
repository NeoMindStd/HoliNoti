import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holinoti_admin/bloc/facility_input_bloc.dart';
import 'package:holinoti_admin/constants/themes.dart' as Themes;
import 'package:holinoti_admin/data/kakao_address.dart';

class SelectAddress extends StatelessWidget {
  final FacilityInputBloc _facilityInputBloc;

  SelectAddress(this._facilityInputBloc);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10, // has the effect of softening the shadow
                    spreadRadius: 1, // has the effect of extending the shadow
                    offset: Offset(
                      1, // horizontal, move right 10
                      1, // vertical, move down 10
                    ),
                  )
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "검색",
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Themes.Colors.ORANGE,
                      size: 28,
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(20),
                ),
                onSubmitted: (String query) =>
                    _facilityInputBloc.queryAddress(query),
              ),
            ),
            Flexible(
              flex: 1,
              child: SingleChildScrollView(
                child: StreamBuilder<List<KakaoAddress>>(
                    initialData: _facilityInputBloc.addresses,
                    stream: _facilityInputBloc.addressStream,
                    builder: (context, snapshot) {
                      assert(snapshot != null && snapshot.data != null);
                      List<KakaoAddress> addresses = snapshot.data;
                      return Column(
                        children: addresses
                            .map((address) => Card(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: InkWell(
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(address.addressName),
                                                Text(address.buildingName),
                                                Text(address.zoneNo),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () => _facilityInputBloc
                                        .tapKakaoAddress(context, address),
                                  ),
                                ))
                            .toList(),
                      );
                    }),
              ),
            ),
          ],
        ),
      );
}
