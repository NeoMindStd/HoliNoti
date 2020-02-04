import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holinoti_admin/bloc/register_facility_bloc.dart';
import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/data/opening_info.dart';
import 'package:holinoti_admin/screens/widgets/global/center_card.dart';

class InputCard extends StatelessWidget {
  final RegisterFacilityBloc _registerFacilityBloc;
  final double appBarHeight;

  InputCard(this._registerFacilityBloc, this.appBarHeight);

  @override
  Widget build(BuildContext context) => CenterCard(
        appBarHeight: appBarHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("가게 정보 등록 페이지"),
            TextField(
              decoration: InputDecoration(
                labelText: "가게 이름",
              ),
              autofocus: true,
              onChanged: _registerFacilityBloc.setFacilityName,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "가게 주소",
              ),
              autofocus: true,
              onChanged: _registerFacilityBloc.setFacilityAddress,
            ),
            Row(
              children: <Widget>[
                Text("영업일: "),
                StreamBuilder<OpeningInfo>(
                  initialData: _registerFacilityBloc.openingInfo,
                  stream: _registerFacilityBloc.openingInfoStream,
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
                        onChanged: _registerFacilityBloc.setBusinessDayStart,
                      ),
                    ),
                  ),
                ),
                Text("~"),
                StreamBuilder<OpeningInfo>(
                  initialData: _registerFacilityBloc.openingInfo,
                  stream: _registerFacilityBloc.openingInfoStream,
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
                        onChanged: _registerFacilityBloc.setBusinessDayEnd,
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
                  initialData: _registerFacilityBloc.openingInfo,
                  stream: _registerFacilityBloc.openingInfoStream,
                  builder: (context, snapshot) => SizedBox(
                    width: 80,
                    height: 30,
                    child: InkWell(
                      child:
                          Center(child: Text(snapshot.data.openingHoursStart)),
                      onTap: () =>
                          _registerFacilityBloc.setOpeningHoursStart(context),
                    ),
                  ),
                ),
                Text("~"),
                StreamBuilder<OpeningInfo>(
                  initialData: _registerFacilityBloc.openingInfo,
                  stream: _registerFacilityBloc.openingInfoStream,
                  builder: (context, snapshot) => SizedBox(
                    width: 80,
                    height: 30,
                    child: InkWell(
                      child: Center(child: Text(snapshot.data.openingHoursEnd)),
                      onTap: () =>
                          _registerFacilityBloc.setOpeningHoursEnd(context),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
