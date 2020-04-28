import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:holinoti_customer/bloc/auth_bloc.dart';
import 'package:holinoti_customer/bloc/facilities_bloc.dart';
import 'package:holinoti_customer/bloc/home_bloc.dart';
import 'package:holinoti_customer/constants/strings.dart' as Strings;
import 'package:holinoti_customer/screens/profile.dart';
import 'package:holinoti_customer/screens/settings.dart';
import 'package:holinoti_customer/utils/data_manager.dart';

class HomePage extends StatelessWidget {
  final HomeBloc _homeBloc;

  HomePage(this._homeBloc);

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _routePages = [
      PlatformButton(
        androidFlat: (BuildContext context) => MaterialFlatButtonData(
          child: Text(
            '시설 목록',
            style: optionStyle,
          ),
          onPressed: () =>
              _homeBloc.moveToFacilitiesPage(context, FacilitiesBloc()),
        ),
      ),
      PlatformButton(
        androidFlat: (BuildContext context) => MaterialFlatButtonData(
          child: Text(
            "임시1",
            style: optionStyle,
          ),
          onPressed: () {},
        ),
      ),
      PlatformButton(
        androidFlat: (BuildContext context) => MaterialFlatButtonData(
          child: Text(
            '임시2',
            style: optionStyle,
          ),
          onPressed: () {},
        ),
      ),
    ];

    return StreamBuilder<int>(
      initialData: 0,
      stream: _homeBloc.tapIndexStream,
      builder: (context, snapshot) => Scaffold(
        appBar: AppBar(
            leading: IconButton(icon: Icon(Icons.home), onPressed: () {}),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SettingsPage()));
                },
              ),
              IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                },
              ),
            ]),
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
              icon: Icon(Icons.home),
              title: Text(Strings.HomePage.HOME),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              title: Text("임시1"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text("임시2"),
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
