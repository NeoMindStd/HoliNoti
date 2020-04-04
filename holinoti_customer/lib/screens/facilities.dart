import 'package:flutter/material.dart';
import 'package:holinoti_customer/bloc/facilities_bloc.dart';
import 'package:holinoti_customer/bloc/facility_bloc.dart';
import 'package:holinoti_customer/data/facility.dart';
import 'package:holinoti_customer/screens/widgets/facilities/facility_card.dart';

class FacilitiesPage extends StatelessWidget {
  final FacilitiesBloc _facilitiesBloc;

  FacilitiesPage(this._facilitiesBloc);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('시설 목록'),
        ),
        body: FutureBuilder<List<Facility>>(
            initialData: [],
            future: _facilitiesBloc.requestFacilities(),
            builder: (context, snapshot) {
              List<Widget> tl = [];
              for (Facility facility in snapshot.data) {
                tl.add(FacilityCard(
                  FacilityBloc(facility),
                  onTap: () =>
                      _facilitiesBloc.moveToFacilityPage(context, facility),
                ));
              }
              return ListView(
                scrollDirection: Axis.vertical,
                children: tl,
              );
            }),
      );
}
