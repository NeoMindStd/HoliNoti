import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:holinoti_admin/bloc/auth_bloc.dart';
import 'package:holinoti_admin/bloc/home_bloc.dart';
import 'package:holinoti_admin/bloc/register_facility_bloc.dart';
import 'package:holinoti_admin/bloc/register_opening_info_bloc.dart';
import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/utils/data_manager.dart';

class HomePage extends StatelessWidget {
  final HomeBloc _homeBloc;

  HomePage(this._homeBloc);

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _routePages = [
      Text(
        '어플 홈 화면',
        style: optionStyle,
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
        appBar: AppBar(
          title: const Text('관리자용 UI 예시'),
        ),
        body: Center(
          child: _routePages[snapshot.data],
        ),
        endDrawer: Drawer(
          child: ListView(
            children: <Widget>[
              DataManager().signedIn == null
                  ? Container()
                  : Text(
                      "${DataManager().signedIn.account}(${DataManager().signedIn.name})님 반갑습니다!"),
              PlatformButton(
                child: Text(DataManager().signedIn == null
                    ? Strings.GlobalPage.SIGN_IN
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
              title: Text(Strings.HomePage.SHOP_MENU),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              title: Text(Strings.HomePage.RESISTER_SHOP),
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
