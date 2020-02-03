import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:holinoti_admin/bloc/home_bloc.dart';
import 'package:holinoti_admin/bloc/auth_bloc.dart';
import 'package:holinoti_admin/bloc/register_facility_bloc.dart';
import 'package:holinoti_admin/bloc/register_opening_info_bloc.dart';
import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/screens/auth.dart';
import 'package:holinoti_admin/screens/widgets/global/center_card.dart';
import 'package:holinoti_admin/screens/widgets/global/lower_half.dart';
import 'package:holinoti_admin/screens/widgets/global/upper_half.dart';
import 'package:holinoti_admin/screens/widgets/register_facility/input_card.dart';
import 'package:holinoti_admin/utils/data_manager.dart';

class RegisterOpeningInfoPage extends StatelessWidget {
  final RegisterOpeningInfoBloc _registerOpeningInfoBloc;

  RegisterOpeningInfoPage(this._registerOpeningInfoBloc);

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      title: const Text('비정기 휴일 등록'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.check),
          onPressed: () {},
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            LowerHalf(appBarHeight: appBar.preferredSize.height,),
            UpperHalf(appBarHeight: appBar.preferredSize.height,),
            CenterCard(
              appBarHeight: appBar.preferredSize.height,
              child: Column(
                children: <Widget>[
                  InkWell(
                    child: Text("비정기 휴일"),
                    onTap: (){ showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                      firstDate: DateTime.now().add(Duration(days: -1)),
                      lastDate: DateTime.now().add(Duration(days: 365)),
                    );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}