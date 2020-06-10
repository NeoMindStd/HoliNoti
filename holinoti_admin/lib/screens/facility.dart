import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:holinoti_admin/bloc/facility_bloc.dart';
import 'package:holinoti_admin/bloc/facility_input_bloc.dart';
import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/constants/themes.dart' as Themes;
import 'package:holinoti_admin/screens/widgets/facility/facility_card.dart';
import 'package:holinoti_admin/screens/widgets/facility/input_card.dart';
import 'package:holinoti_admin/screens/widgets/global/lower_half.dart';
import 'package:holinoti_admin/screens/widgets/global/upper_half.dart';
import 'package:intl/intl.dart';

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
                        Future<bool> _onWillPop(void onDismiss()) async {
                          if (onDismiss != null) onDismiss();
                          return true;
                        }

                        onConfirm() {}
                        switch (index) {
                          case 0:
                            showCupertinoDialog(
                              context: context,
                              builder: (context) => WillPopScope(
                                onWillPop: () async => _onWillPop(onConfirm),
                                child: PlatformAlertDialog(
                                  title: Text(Strings.GlobalPage.ALERT_TITLE),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      TextField(
                                        decoration:
                                            InputDecoration(labelText: "휴업 사유"),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text("휴업일:"),
                                          StreamBuilder<DateTime>(
                                              initialData:
                                                  _facilityBloc.holidayStart,
                                              stream: _facilityBloc
                                                  .holidayStartStream,
                                              builder: (context, snapshot) {
                                                assert(snapshot != null &&
                                                    snapshot.data != null);
                                                return FlatButton(
                                                    child: Text(DateFormat(
                                                            'yyyy-MM-dd')
                                                        .format(snapshot.data)),
                                                    onPressed: () async =>
                                                        _facilityBloc
                                                                .holidayStart =
                                                            await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime.now(),
                                                          lastDate: DateTime(
                                                              DateTime.now()
                                                                      .year +
                                                                  1),
                                                        ));
                                              }),
                                          Text("~"),
                                          StreamBuilder<DateTime>(
                                              initialData:
                                                  _facilityBloc.holidayEnd,
                                              stream: _facilityBloc
                                                  .holidayEndStream,
                                              builder: (context, snapshot) {
                                                assert(snapshot != null &&
                                                    snapshot.data != null);
                                                return FlatButton(
                                                    child: Text(DateFormat(
                                                            'yyyy-MM-dd')
                                                        .format(snapshot.data)),
                                                    onPressed: () async =>
                                                        _facilityBloc
                                                                .holidayEnd =
                                                            await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime.now(),
                                                          lastDate: DateTime(
                                                              DateTime.now()
                                                                      .year +
                                                                  3),
                                                        ));
                                              })
                                        ],
                                      ),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    PlatformButton(
                                      androidFlat: (BuildContext context) =>
                                          MaterialFlatButtonData(
                                        child: Text(
                                            Strings.GlobalPage.BUTTON_CONFIRM),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          if (onConfirm != null) onConfirm();
                                        },
                                      ),
                                      ios: (BuildContext context) =>
                                          CupertinoButtonData(
                                        child: Text(
                                            Strings.GlobalPage.BUTTON_CONFIRM),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          if (onConfirm != null) onConfirm();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
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
