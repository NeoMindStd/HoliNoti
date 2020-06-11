import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holinoti_admin/bloc/facility_bloc.dart';
import 'package:holinoti_admin/bloc/facility_input_bloc.dart';
import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/constants/themes.dart' as Themes;
import 'package:holinoti_admin/screens/widgets/facility/facility_card.dart';
import 'package:holinoti_admin/screens/widgets/facility/input_card.dart';
import 'package:holinoti_admin/screens/widgets/global/lower_half.dart';
import 'package:holinoti_admin/screens/widgets/global/upper_half.dart';
import 'package:holinoti_admin/utils/dialog.dart';

class FacilityPage extends StatelessWidget {
  final FacilityBloc _facilityBloc;
  final FacilityInputBloc _facilityInputBloc;

  FacilityPage(this._facilityBloc, this._facilityInputBloc);

  @override
  Widget build(BuildContext context) => StreamBuilder<bool>(
      initialData: _facilityBloc.isUpdateMode,
      stream: _facilityBloc.updateModeStream,
      builder: (context, snapshot) {
        return snapshot.data
            ? Scaffold(
                appBar: AppBar(
                  title: Text(
                    Strings.FacilityPage.EDIT_FACILITY,
                    style: TextStyle(
                        color: Themes.Colors.ORANGE,
                        fontWeight: FontWeight.bold),
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async =>
                          await _facilityInputBloc.deleteFacility(context),
                    ),
                    IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () async {
                          _facilityBloc.facility =
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
                    child: Stack(
                      children: <Widget>[
                        LowerHalf(),
                        UpperHalf(),
                        InputCard(_facilityInputBloc),
                      ],
                    ),
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
                      onSelected: (int index) async {
                        switch (index) {
                          case 0:
                            await AppDialog(context).showTempHolidayDialog(
                                facilityBloc: _facilityBloc);
                            break;
                          case 1:
                            _facilityBloc.updateMode = true;
                            break;
                          case 2:
                            await _facilityInputBloc.deleteFacility(context);
                            break;
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<int>>[
                        const PopupMenuItem<int>(
                          value: 0,
                          child: Text("휴업일 관리"),
                        ),
                        const PopupMenuItem<int>(
                          value: 1,
                          child: Text(Strings.GlobalPage.EDIT),
                        ),
                        const PopupMenuItem<int>(
                          value: 2,
                          child: Text(Strings.GlobalPage.DELETE),
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
