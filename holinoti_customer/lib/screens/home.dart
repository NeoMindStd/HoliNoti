import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:holinoti_customer/bloc/facilities_bloc.dart';
import 'package:holinoti_customer/bloc/home_bloc.dart';
import 'package:holinoti_customer/constants/strings.dart' as Strings;
import 'Login.dart';

class HomePage extends StatelessWidget {
  final HomeBloc _homeBloc;

  HomePage(this._homeBloc);

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {

    final List<Widget> _routePages = [
      Container(
        child: Column(
          children: <Widget>[
            Text('환영합니다'),
            Image.asset(Strings.Assets.RESTAURANT_JPG),
            PlatformButton(
              android: (BuildContext context) => MaterialRaisedButtonData(
                child:Text(
                  '로그인',
                  style: optionStyle,
                ),
              ),
            ),
            PlatformButton(
              android: (BuildContext context) => MaterialRaisedButtonData(
                child:Text(
                '로그인없이',
                style: optionStyle,
              ),
              ),
            ),
          ],
        ),
        color:Colors.blue,
      ),
      PlatformButton(
        androidFlat: (BuildContext context) => MaterialFlatButtonData(
          child: Text(//메인 화면 텍스트
            '가게 검색 들어가기',
            style: optionStyle,
          ),
          onPressed: () =>
              _homeBloc.moveToFacilitiesPage(context, FacilitiesBloc()),//시설 목록으로 이동
        ),
      ),
      PlatformButton(
        androidFlat: (BuildContext context) => MaterialFlatButtonData(//즐겨찾기 목록으로 이동
          child: Text(
            "즐겨찾기",
            style: optionStyle,
          ),
          onPressed: () {},
        ),
      ),
      PlatformButton(
        androidFlat: (BuildContext context) => MaterialFlatButtonData(//알람 목록으로 이동
          child: Text(
            '알람',
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
        appBar: AppBar(//타이틀
          title: const Text('휴일 알림이'),
        ),
        body: Center(
          child: _routePages[snapshot.data],
        ),

        endDrawer: Drawer(
          child: ListView(
            children: <Widget>[
              MoveButton()
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(//아래 네비게이션 바
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(Strings.HomePage.HOME),
            ),
            BottomNavigationBarItem(//즐겨찾기 부분 이동
              icon: Icon(Icons.store),
              title: Text("즐겨찾기"),
            ),
            BottomNavigationBarItem(//알람부분 이동
              icon: Icon(Icons.hotel),
              title: Text("알람"),
            ),
          ],
          currentIndex: snapshot.data,
          selectedItemColor: Colors.amber[800],//선택된거
          onTap: _homeBloc.onTapChanged,
        ),
      ),
    );
  }
}
class MoveButton extends StatelessWidget{//로그인 버튼
  Widget build(BuildContext context){
    return Center(
      child:RaisedButton(
        child: Text('로그인'),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder:(context)=>Login())
          );
        },
      ),
    );
  }
}
class MainPoto extends StatelessWidget{//사진
  Widget build(BuildContext context){
    return Center(
      child: Image.asset(
        Strings.Assets.RESTAURANT_JPG,
        width:400,
        height:100,
        fit: BoxFit.fill,
      ),
    );
  }
}
