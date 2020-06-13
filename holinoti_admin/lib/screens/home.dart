import 'package:flutter/material.dart';
import 'package:holinoti_admin/bloc/facility_input_bloc.dart';
import 'package:holinoti_admin/bloc/home_bloc.dart';
import 'package:holinoti_admin/bloc/settings_bloc.dart';
import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/constants/themes.dart' as Themes;
import 'package:holinoti_admin/screens/notice.dart';
import 'package:holinoti_admin/screens/settings.dart';
import 'package:holinoti_admin/screens/widgets/facility/input_card.dart';
import 'package:holinoti_admin/screens/widgets/home/facility_list_column.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              onPressed: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SettingsPage(SettingsBloc(pref))));
              }),
          IconButton(
            icon: const Icon(
              Icons.person,
              color: Themes.Colors.ORANGE,
              size: 28,
            ),
            onPressed: () => _homeBloc.moveToAuthOrProfilePage(context),
          ),
        ],
        backgroundColor: Themes.Colors.WHITE,
      ),
      AppBar(
        title: Text(
          Strings.HomePage.RESISTER_FACILITY,
          style: TextStyle(
              color: Themes.Colors.ORANGE, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Themes.Colors.ORANGE,
              size: 28,
            ),
            onPressed: () => _facilityInputBloc.dispose(),
          ),
          IconButton(
            icon: const Icon(
              Icons.check,
              color: Themes.Colors.ORANGE,
              size: 28,
            ),
            onPressed: () async {
              await _facilityInputBloc.registerFacility();
              _homeBloc.onTapChanged(0);
            },
          )
        ],
        backgroundColor: Themes.Colors.WHITE,
      ),
      AppBar(
        leading: Icon(
          Icons.notifications_none,
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
              onPressed: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SettingsPage(SettingsBloc(pref))));
              }),
          IconButton(
            icon: const Icon(
              Icons.person,
              color: Themes.Colors.ORANGE,
              size: 28,
            ),
            onPressed: () => _homeBloc.moveToAuthOrProfilePage(context),
          ),
        ],
        backgroundColor: Themes.Colors.WHITE,
      ),
      AppBar(
        title: Text(
          Strings.GlobalPage.NOTICE_LIST,
          style: TextStyle(
              color: Themes.Colors.ORANGE, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
              icon: const Icon(
                Icons.settings,
                color: Themes.Colors.ORANGE,
                size: 28,
              ),
              onPressed: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SettingsPage(SettingsBloc(pref))));
              }),
          IconButton(
            icon: const Icon(
              Icons.person,
              color: Themes.Colors.ORANGE,
              size: 28,
            ),
            onPressed: () => _homeBloc.moveToAuthOrProfilePage(context),
          ),
        ],
        backgroundColor: Themes.Colors.WHITE,
      ),
    ];

    final TextEditingController searchController = TextEditingController();

    final List<Widget> _routePages = [
      Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    "검색 거리",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Themes.Colors.ORANGE),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: StreamBuilder(
                    initialData: 2,
                    stream: _homeBloc.distanceIndexStream,
                    builder: (context, snapshot) {
                      assert(snapshot != null &&
                          snapshot.data != null &&
                          snapshot.data is int &&
                          snapshot.data >= 0 &&
                          snapshot.data <
                              Strings.HomePage.DISTANCE_LIST.length);
                      return DropdownButtonHideUnderline(
                        child: DropdownButton(
                          iconEnabledColor: Themes.Colors.ORANGE,
                          isExpanded: true,
                          items: List.generate(
                                  Strings.HomePage.DISTANCE_LIST.length,
                                  (index) => index)
                              .map((index) => DropdownMenuItem(
                                    value: index,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        Strings.HomePage.DISTANCE_LIST[index],
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Themes.Colors.ORANGE),
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value: snapshot.data,
                          onChanged: (index) =>
                              _homeBloc.onDistanceIndexChanged(index),
                        ),
                      );
                    }),
              ),
            ]),
          ),
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
              controller: searchController,
              decoration: InputDecoration(
                hintText: Strings.GlobalPage.SEARCH,
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Themes.Colors.ORANGE,
                    size: 28,
                  ),
                  onPressed: () => _homeBloc.search(searchController.text),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(20),
              ),
              onSubmitted: (t) => _homeBloc.search(searchController.text),
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
      NoticeColumn(),
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
              title: Text(Strings.HomePage.FACILITY_LIST),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                color: Themes.Colors.APRICOT,
                size: 28,
              ),
              activeIcon: Icon(
                Icons.add,
                color: Themes.Colors.WHITE,
                size: 28,
              ),
              title: Text(Strings.HomePage.RESISTER_FACILITY),
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
              title: Text(""),
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
              title: Text(Strings.HomePage.REGISTER_TEMP_HOLIDAY),
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
