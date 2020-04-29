import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holinoti_admin/bloc/facility_bloc.dart';
import 'package:holinoti_admin/bloc/home_bloc.dart';
import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/constants/themes.dart' as Themes;
import 'package:holinoti_admin/data/facility.dart';
import 'package:holinoti_admin/data/user.dart';
import 'package:holinoti_admin/utils/data_manager.dart';

class FacilitiesListColumn extends StatelessWidget {
  final HomeBloc _homeBloc;

  FacilitiesListColumn(this._homeBloc);

  @override
  Widget build(BuildContext context) => StreamBuilder<User>(
      initialData: DataManager().currentUser,
      stream: DataManager().dataBloc.currentUserStream,
      builder: (context, snapshot) {
        User currentUser = snapshot.data;
        return Column(
            children: ((currentUser != null ? currentUser.facilities : [])
                .map((facility) => Card(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: InkWell(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // TODO 튀어나간 텍스트 스크롤처리 or 말줄임표
                                    Text(
                                      (facility as Facility).name,
                                      style: TextStyle(
                                        color: Themes.Colors.ORANGE,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text("영업여부 및 운영시간"),
                                    Text((facility as Facility).address),
                                    Text((facility as Facility).phoneNumber),
                                    Text((facility as Facility).comment),
                                  ],
                                ),
                              ),
                              SizedBox.fromSize(
                                  size: Size.square(100),
                                  child: Image.asset(
                                      Strings.Assets.RESTAURANT_JPG))
                            ],
                          ),
                        ),
                        onTap: () => _homeBloc.moveToFacilityPage(
                            context, FacilityBloc(facility)),
                      ),
                    ))
                .toList()));
      });
}
