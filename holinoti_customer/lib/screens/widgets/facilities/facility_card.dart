import 'package:flutter/material.dart';
import 'package:holinoti_customer/bloc/facility_bloc.dart';
import 'package:holinoti_customer/data/facility.dart';
import 'package:holinoti_customer/data/opening_info.dart';

class FacilityCard extends StatelessWidget{

  final FacilityBloc _facilityBloc;
  final onTap;

  FacilityCard(this._facilityBloc, {this.onTap});

  @override
  Widget build(BuildContext context) => Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    elevation: 8,
    child: InkWell(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            Text("시설명: ${_facilityBloc.facility.name}"),
            Text("주소: ${_facilityBloc.facility.address}"),
          ],
        ),
      ),
      onTap: onTap,
    ),
  );
}