import 'package:flutter/material.dart';
import 'package:holinoti_customer/bloc/facility_bloc.dart';
import 'package:holinoti_customer/constants/themes.dart' as Themes;
import 'package:holinoti_customer/screens/widgets/facility/facility_card.dart';

class FacilityPage extends StatelessWidget {
  // To adjust the layout according to the screen size
  // so that our layout remains responsive ,we need to
  // calculate the screen height
  // Set initial mode to sign in

  final FacilityBloc _facilityBloc;

  FacilityPage(this._facilityBloc);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.arrow_back,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite),
            )
          ],
          iconTheme: IconThemeData(size: 28, color: Themes.Colors.ORANGE),
          backgroundColor: Themes.Colors.WHITE,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: FacilityCard(_facilityBloc),
          ),
        ),
      );
}
