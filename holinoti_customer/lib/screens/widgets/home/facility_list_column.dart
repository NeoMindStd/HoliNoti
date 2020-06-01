import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holinoti_customer/bloc/facility_bloc.dart';
import 'package:holinoti_customer/bloc/home_bloc.dart';
import 'package:holinoti_customer/constants/strings.dart' as Strings;
import 'package:holinoti_customer/constants/themes.dart' as Themes;
import 'package:holinoti_customer/data/facility.dart';
import 'package:holinoti_customer/screens/widgets/global/favorite_button.dart';
import 'package:holinoti_customer/utils/data_manager.dart';

class FacilitiesListColumn extends StatelessWidget {
  final HomeBloc _homeBloc;

  FacilitiesListColumn(this._homeBloc);

  @override
  Widget build(BuildContext context) => StreamBuilder<List<Facility>>(
      initialData: DataManager().facilities,
      stream: DataManager().dataBloc.facilitiesStream,
      builder: (context, snapshot) {
        List<Facility> facilities = snapshot.data ?? [];
        return Column(
            children: facilities
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
                                      facility.name,
                                      style: TextStyle(
                                        color: Themes.Colors.ORANGE,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(Strings
                                        .HomePage.OPENING_INFO_AND_IS_OPEN),
                                    Text(facility.address),
                                    Text(facility.phoneNumber),
                                    Text(facility.comment),
                                  ],
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  SizedBox.fromSize(
                                      size: Size.square(100),
                                      child: Image.asset(
                                          Strings.Assets.RESTAURANT_JPG)),
                                  FavoriteButton(facility.code, context),
                                ],
                              ),
                            ],
                          ),
                        ),
                        onTap: () => _homeBloc.moveToFacilityPage(
                            context, FacilityBloc(facility)),
                      ),
                    ))
                .toList());
      });
}
