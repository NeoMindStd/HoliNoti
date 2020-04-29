import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:holinoti_admin/bloc/auth_bloc.dart';
import 'package:holinoti_admin/bloc/facility_input_bloc.dart';
import 'package:holinoti_admin/bloc/home_bloc.dart';
import 'package:holinoti_admin/bloc/register_opening_info_bloc.dart';
import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/screens/widgets/facility/input_card.dart';
import 'package:holinoti_admin/screens/widgets/home/facility_list_column.dart';
import 'package:holinoti_admin/utils/data_manager.dart';

class HomePage extends StatelessWidget {
  final HomeBloc _homeBloc;
  final FacilityInputBloc _facilityInputBloc;

  HomePage(this._homeBloc, this._facilityInputBloc);

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final List<AppBar> _appBars = [
      AppBar(
        leading: Icon(
          Icons.home,
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
      ),
      AppBar(
        title: Text("신규 시설 등록"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () async {
              await _facilityInputBloc.registerFacility();
              _homeBloc.onTapChanged(0);
            },
          )
        ],
      ),
      AppBar(
        leading: Icon(
          Icons.notifications_none,
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
      ),
      AppBar(
        title: Text("공지목록"),
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
      ),
    ];

    final List<Widget> _routePages = [
      Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10, // has the effect of softening the shadow
                  spreadRadius: 1, // has the effect of extending the shadow
                  offset: Offset(
                    1, // horizontal, move right 10
                    1, // vertical, move down 10
                  ),
                )
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "검색",
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(20),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: SingleChildScrollView(
              child: FacilitiesListColumn(_homeBloc),
            ),
          ),
        ],
      ),
      SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            InputCard(
              _facilityInputBloc,
            ),
          ],
        ),
      ),
      SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            InputCard(
              _facilityInputBloc,
            ),
          ],
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
        appBar: _appBars[snapshot.data],
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
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              title: Text(Strings.HomePage.RESISTER_FACILITY),
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              title: Text(""),
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.hotel),
              title: Text(Strings.HomePage.REGISTER_TEMP_HOLIDAY),
              backgroundColor: Colors.blue,
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: snapshot.data,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.white,
          onTap: _homeBloc.onTapChanged,
        ),
      ),
    );
  }
}
