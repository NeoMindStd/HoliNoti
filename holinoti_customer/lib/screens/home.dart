import 'package:flutter/material.dart';
import 'package:holinoti_customer/bloc/home_bloc.dart';
import 'package:holinoti_customer/constants/strings.dart' as Strings;
import 'package:holinoti_customer/constants/themes.dart' as Themes;
import 'package:holinoti_customer/screens/notice.dart';
import 'package:holinoti_customer/screens/settings.dart';
import 'package:holinoti_customer/screens/widgets/home/facility_list_column.dart';

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
          color: Themes.Colors.ORANGE,
          size: 28,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Themes.Colors.ORANGE,
              size: 28,
            ),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingsPage())),
          ),
          IconButton(
            icon: const Icon(
              Icons.person,
              color: Themes.Colors.ORANGE,
              size: 28,
            ),
            onPressed: () => _homeBloc.moveToAuthOrProfilePage(context),
          )
        ],
        backgroundColor: Themes.Colors.WHITE,
      ),
      AppBar(
        leading: Icon(
          Icons.notifications_none,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Themes.Colors.ORANGE,
              size: 28,
            ),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingsPage())),
          ),
          IconButton(
            icon: const Icon(
              Icons.person,
              color: Themes.Colors.ORANGE,
              size: 28,
            ),
            onPressed: () => _homeBloc.moveToAuthOrProfilePage(context),
          )
        ],
        backgroundColor: Themes.Colors.WHITE,
      ),
      AppBar(
        title: Text("공지목록"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Themes.Colors.ORANGE,
              size: 28,
            ),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingsPage())),
          ),
          IconButton(
            icon: const Icon(
              Icons.person,
              color: Themes.Colors.ORANGE,
              size: 28,
            ),
            onPressed: () => _homeBloc.moveToAuthOrProfilePage(context),
          )
        ],
        backgroundColor: Themes.Colors.WHITE,
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
                  icon: Icon(
                    Icons.search,
                    color: Themes.Colors.ORANGE,
                    size: 28,
                  ),
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
            Text("알림 목록"),
          ],
        ),
      ),
      SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            NoticeColumn(),
          ],
        ),
      ),
    ];

    return StreamBuilder<int>(
      initialData: 0,
      stream: _homeBloc.tapIndexStream,
      builder: (context, snapshot) => Scaffold(
        appBar: _appBars[snapshot.data],
        body: Container(
          child: _routePages[snapshot.data],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Themes.Colors.APRICOT, size: 28),
              activeIcon: Icon(
                Icons.home,
                color: Themes.Colors.WHITE,
                size: 28,
              ),
              title: Text(Strings.HomePage.HOME),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
                color: Themes.Colors.APRICOT,
                size: 28,
              ),
              activeIcon: Icon(
                Icons.notifications,
                color: Themes.Colors.WHITE,
                size: 28,
              ),
              title: Text("알림 목록"),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.format_list_bulleted,
                color: Themes.Colors.APRICOT,
                size: 28,
              ),
              activeIcon: Icon(
                Icons.format_list_bulleted,
                color: Themes.Colors.WHITE,
                size: 28,
              ),
              title: Text("공지 목록"),
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: snapshot.data,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Themes.Colors.ORANGE,
          onTap: _homeBloc.onTapChanged,
        ),
      ),
    );
  }
}
