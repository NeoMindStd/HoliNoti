import 'package:flutter/material.dart';
import 'package:holinoti_admin/bloc/facility_bloc.dart';
import 'package:holinoti_admin/bloc/facility_input_bloc.dart';
import 'package:holinoti_admin/constants/themes.dart' as Themes;
import 'package:holinoti_admin/data/facility.dart';
import 'package:holinoti_admin/screens/widgets/facility/facility_card.dart';
import 'package:holinoti_admin/screens/widgets/facility/input_card.dart';
import 'package:holinoti_admin/screens/widgets/global/lower_half.dart';
import 'package:holinoti_admin/screens/widgets/global/upper_half.dart';

// ignore: must_be_immutable
class FacilityPage extends StatelessWidget {
  // To adjust the layout according to the screen size
  // so that our layout remains responsive ,we need to
  // calculate the screen height
  // Set initial mode to sign in

  final FacilityBloc _facilityBloc;
  FacilityInputBloc _facilityInputBloc;

  FacilityPage(this._facilityBloc) {
    _facilityInputBloc = FacilityInputBloc(facility: _facilityBloc.facility);
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<bool>(
      initialData: _facilityBloc.isUpdateMode,
      stream: _facilityBloc.updateModeStream,
      builder: (context, snapshot) {
        return snapshot.data
            ? Scaffold(
                appBar: AppBar(
                  title: Text(
                    "시설 정보 수정",
                    style: TextStyle(
                        color: Themes.Colors.ORANGE,
                        fontWeight: FontWeight.bold),
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {},
                    ),
                    IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () async {
                          await _facilityInputBloc.registerFacility();
                          _facilityBloc.updateMode = false;
                        })
                  ],
                  iconTheme:
                      IconThemeData(size: 28, color: Themes.Colors.ORANGE),
                  backgroundColor: Themes.Colors.WHITE,
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: StreamBuilder<Facility>(
                        initialData: _facilityBloc.facility,
                        stream: _facilityBloc.facilityStream,
                        builder: (context, snapshot) {
                          return Stack(
                            children: <Widget>[
                              LowerHalf(),
                              UpperHalf(),
                              InputCard(_facilityInputBloc),
                            ],
                          );
                        }),
                  ),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  leading: Icon(
                    Icons.arrow_back,
                  ),
                  actions: <Widget>[
                    PopupMenuButton<int>(
                      icon: const Icon(Icons.more_vert),
                      onSelected: (int index) {
                        switch (index) {
                          case 0:
                            _facilityBloc.updateMode = true;
                            break;
                          case 1:
                            break;
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<int>>[
                        const PopupMenuItem<int>(
                          value: 0,
                          child: Text('수정'),
                        ),
                        const PopupMenuItem<int>(
                          value: 1,
                          child: Text('삭제'),
                        ),
                      ],
                    ),
                  ],
                  iconTheme:
                      IconThemeData(size: 28, color: Themes.Colors.ORANGE),
                  backgroundColor: Themes.Colors.WHITE,
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: FacilityCard(_facilityBloc),
                  ),
                ),
              );
      });
}
