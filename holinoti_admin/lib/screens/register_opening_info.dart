import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holinoti_admin/bloc/register_opening_info_bloc.dart';
import 'package:holinoti_admin/screens/widgets/global/center_card.dart';
import 'package:holinoti_admin/screens/widgets/global/lower_half.dart';
import 'package:holinoti_admin/screens/widgets/global/upper_half.dart';

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
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      InkWell(
                        child: Text("비정기 휴일 등록"),
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now().add(Duration(days: -1)),
                            lastDate: DateTime.now().add(Duration(days: 365)),
                          );
                        },
                      ),
                    ],
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "휴업 사유",
                    ),
                    autofocus: true,
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
