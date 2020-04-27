import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:holinoti_admin/bloc/auth_bloc.dart';
import 'package:holinoti_admin/bloc/home_bloc.dart';
import 'package:holinoti_admin/bloc/register_facility_bloc.dart';
import 'package:holinoti_admin/bloc/register_opening_info_bloc.dart';
import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/screens/widgets/global/lower_half.dart';
import 'package:holinoti_admin/screens/widgets/global/upper_half.dart';
import 'package:holinoti_admin/screens/widgets/home/facility_list_card.dart';
import 'package:holinoti_admin/utils/data_manager.dart';

class HomePage extends StatelessWidget {
  final HomeBloc _homeBloc;
  final AppBar appBar = AppBar(
    leading: GestureDetector(
      onTap: () {},
      child: Icon(
        Icons.home,
      ),
    ),
    actions: <Widget>[
      IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () {},
      ),
      IconButton(
        icon: const Icon(Icons.person_outline),
        onPressed: () {},
      )
    ],
  );

  HomePage(this._homeBloc);

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {

    final List<Widget> _routePages = [
      SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            LowerHalf(
              appBarHeight: appBar.preferredSize.height,
            ),
            UpperHalf(
              appBarHeight: appBar.preferredSize.height,
            ),
            FacilitiesListCard(appBar.preferredSize.height),
          ],
        ),
      ),
      PlatformButton(
        androidFlat: (BuildContext context) => MaterialFlatButtonData(
          child: Text(
            "가게 등록 페이지",
            style: optionStyle,
          ),
          onPressed: () => _homeBloc.moveToRegisterFacilityPage(
              context, RegisterFacilityBloc()),
        ),
      ),
      PlatformButton(
        androidFlat: (BuildContext context) => MaterialFlatButtonData(
          child: Text(
            '임시 휴업일 추가 페이지',
            style: optionStyle,
          ),
          onPressed: () => _homeBloc.moveToRegisterOpeningInfoPage(
              context, RegisterOpeningInfoBloc()),
        ),
      ),
    ];

    return StreamBuilder<int>(
      initialData: 0,
      stream: _homeBloc.tapIndexStream,
      builder: (context, snapshot) => Scaffold(
        appBar: appBar,
        body: Center(
          child: _routePages[snapshot.data],
        ),
        endDrawer: Drawer(
          child: ListView(
            children: <Widget>[
              DataManager().currentUser == null
                  ? Container()
                  : Text(
                      "${DataManager().currentUser.account}(${DataManager().currentUser.name})님 반갑습니다!"),
              PlatformButton(
                child: Text(DataManager().currentUser == null
                    ? Strings.GlobalPage.LOGIN
                    : "로그아웃"),
                onPressed: () => _homeBloc.moveToAuthPage(context, AuthBloc()),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              title: Text(Strings.HomePage.FACILITY_LIST),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              title: Text(Strings.HomePage.RESISTER_FACILITY),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.hotel),
              title: Text(Strings.HomePage.REGISTER_TEMP_HOLIDAY),
            ),
          ],
          currentIndex: snapshot.data,
          selectedItemColor: Colors.amber[800],
          onTap: _homeBloc.onTapChanged,
        ),
      ),
    );
  }
}
