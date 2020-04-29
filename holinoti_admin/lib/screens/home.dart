import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:holinoti_admin/bloc/facility_input_bloc.dart';
import 'package:holinoti_admin/bloc/home_bloc.dart';
import 'package:holinoti_admin/bloc/register_opening_info_bloc.dart';
import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/constants/themes.dart' as Themes;
import 'package:holinoti_admin/screens/settings.dart';
import 'package:holinoti_admin/screens/widgets/facility/input_card.dart';
import 'package:holinoti_admin/screens/widgets/home/facility_list_column.dart';

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
          ),
        ],
        backgroundColor: Themes.Colors.WHITE,
      ),
      AppBar(
        title: Text(
          "신규 시설 등록",
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
            onPressed: () {},
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
          ),
        ],
        backgroundColor: Themes.Colors.WHITE,
      ),
      AppBar(
        title: Text(
          "공지 목록",
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
          ),
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
