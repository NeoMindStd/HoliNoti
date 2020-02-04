import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:holinoti_customer/bloc/facilities_bloc.dart';
import 'package:holinoti_customer/bloc/home_bloc.dart';
import 'package:holinoti_customer/constants/strings.dart' as Strings;

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
          title: const Text('고객용 UI 예시'),
        ),
        body: Center(
          child: _routePages[snapshot.data],
        ),
        endDrawer: Drawer(
          child: ListView(
            children: <Widget>[],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(Strings.HomePage.HOME),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              title: Text("임시1"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.hotel),
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
