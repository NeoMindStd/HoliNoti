import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holinoti_admin/bloc/register_facility_bloc.dart';
import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/data/opening_info.dart';
import 'package:holinoti_admin/screens/widgets/global/center_card.dart';
import 'package:holinoti_admin/screens/widgets/global/lower_half.dart';
import 'package:holinoti_admin/screens/widgets/global/upper_half.dart';

// ignore: must_be_immutable
class FacilitiesListCard extends StatelessWidget {
  final double appBarHeight;

  FacilitiesListCard(this.appBarHeight);

  List dummyFacilities = List.generate(4, (i)=>{'name':'Store$i','comment':'Comment$i'});

  @override
  Widget build(BuildContext context) => CenterCard(
      appBarHeight: appBarHeight,
      child: Column(
          children:
          (dummyFacilities.map((facility)=>
              Column(children: <Widget>[ListTile(
                leading: Icon(Icons.store),
                title: Text(facility['name']),
                subtitle: Text(facility['comment']),
              ),
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: const Text('수정'),
                      onPressed: () {},
                    ),
                    FlatButton(
                      child: const Text('삭제'),
                      onPressed: () {},
                    ),
                  ],
                )
              ],)).toList())
      )
  );
}