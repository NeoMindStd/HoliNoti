import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:holinoti_customer/bloc/auth_bloc.dart';
import 'package:holinoti_customer/bloc/facilities_bloc.dart';
import 'package:holinoti_customer/bloc/home_bloc.dart';
import 'package:holinoti_customer/constants/strings.dart' as Strings;
import 'package:holinoti_customer/screens/profile.dart';
import 'package:holinoti_customer/screens/settings.dart';
import 'package:holinoti_customer/screens/widgets/home/facilities.dart';
import 'package:holinoti_customer/utils/data_manager.dart';

class HomePage extends StatelessWidget {
  final HomeBloc _homeBloc;

  HomePage(this._homeBloc);

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
            Text("알림목록"),
          ],
        ),
      ),
      SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Text("공지목록"),
          ],
        ),
      ),
    ];

    return StreamBuilder<int>(
      initialData: 0,
      stream: _homeBloc.tapIndexStream,
      builder: (context, snapshot) =>
          Scaffold(
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
                      "${DataManager().currentUser.account}(${DataManager()
                          .currentUser.name})님 반갑습니다!"),
                  PlatformButton(
                    child: Text(DataManager().currentUser == null
                        ? Strings.GlobalPage.LOGIN
                        : "로그아웃"),
                    onPressed: () =>
                        _homeBloc.moveToAuthPage(context, AuthBloc()),
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
                  icon: Icon(Icons.notifications),
                  title: Text("알림목록"),
                  backgroundColor: Colors.blue,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.hotel),
                  title: Text("공지목록"),
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
