import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:holinoti_admin/bloc/home_bloc.dart';
import 'package:holinoti_admin/bloc/auth_bloc.dart';
import 'package:holinoti_admin/bloc/register_facility_bloc.dart';
import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/screens/auth.dart';
import 'package:holinoti_admin/screens/widgets/global/lower_half.dart';
import 'package:holinoti_admin/screens/widgets/global/upper_half.dart';
import 'package:holinoti_admin/screens/widgets/register_facility/input_card.dart';
import 'package:holinoti_admin/utils/data_manager.dart';

class RegisterFacilityPage extends StatelessWidget {
  final RegisterFacilityBloc _registerFacilityBloc;

  RegisterFacilityPage(this._registerFacilityBloc);

  //  TODO 입력한 값이 키보드 동작시에 사라지지 않도록
  @override
  Widget build(BuildContext context) {
    final _nameController = TextEditingController();
    final _addressController = TextEditingController();

    final AppBar appBar = AppBar(
      title: const Text('가게 등록'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.check),
          onPressed: () => _registerFacilityBloc.registerFacility(
              context,
              _nameController.text,
              _addressController.text
          ),
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
            InputCard(_registerFacilityBloc, appBar.preferredSize.height,),
          ],
        ),
      ),
    );
  }
}