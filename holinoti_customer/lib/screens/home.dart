//메인화면 겸 즐겨찾기 겸 알람 메뉴를 같이 함
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:holinoti_customer/bloc/facilities_bloc.dart';
import 'package:holinoti_customer/bloc/home_bloc.dart';
import 'package:holinoti_customer/constants/strings.dart' as Strings;
import 'Alarm.dart';
import 'Login.dart';
import 'Favoit.dart';

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
            Text('환영합니다', style:optionStyle),
            Image.asset(Strings.Assets.RESTAURANT_JPG),
            PlatformButton(
              android: (BuildContext context) => MaterialRaisedButtonData(
                child:Text(
                  '로그인',
                  style: optionStyle,
                ),
                onPressed:()=>
                    Navigator.push(context,
                        MaterialPageRoute( builder: (BuildContext context)=> LoginPage()))
              ),
            ),
            PlatformButton(
              android: (BuildContext context) => MaterialRaisedButtonData(
                child:Text(
                '가게검색 들어가기',
                style: optionStyle,
              ),
                onPressed: () =>
                    _homeBloc.moveToFacilitiesPage(context, FacilitiesBloc()),
              ),
            ),
          ],
        ),
        //color:Colors.blue,
      ),
      Container(//혹시 버튼 없이 바로 넘기는 방법 알면 추가좀여
        child: Column(
          children:<Widget>[
            Text("즐겨찾기 메뉴 입니다."),
            PlatformButton(
              android:(BuildContext context)=> MaterialRaisedButtonData(
                child:Text(
                  '즐겨찾기 메뉴',
                  style:optionStyle,
                ),
                  onPressed:()=>
                      Navigator.push(context,
                          MaterialPageRoute( builder: (BuildContext context)=> FavoritPage())),
              ),
            ),
          ],
        ),
      ),
      PlatformButton(
        androidFlat: (BuildContext context) => MaterialFlatButtonData(
          child: Text(//메인 화면 텍스트
            '알람 설정 들어가기',
            style: optionStyle,
          ),
          onPressed: () =>
              Navigator.push(context,
              MaterialPageRoute( builder: (BuildContext context)=> AlramSetting()))
        ),
      ),
      //밑에 즐겨찾기하고 알람 버튼 안쓰면 지울것 가게검색도 같이 return 앞까지 적용
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

        endDrawer: Drawer(//옆에 계정 화면 부분
          child: ListView(
            children: <Widget>[
              UserProfile(),
              LoginButton()
              /*
              사용자 계정 사진 작게 넣고
              사용자 이름, 즐겨찾기 연동할것
              */
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
              icon: Icon(Icons.access_alarms),
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
class LoginButton extends StatelessWidget{//로그인 버튼
  Widget build(BuildContext context){
    return Center(
      child:RaisedButton(
        child: Text('로그인'),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder:(context)=>LoginPage())
          );
        },
      ),
    );
  }
}

class UserProfile extends StatelessWidget{//사용자 계정 좀 더 조정 필요 예를 들면 즐겨찾기 몇개 연결한다 등
  TextStyle UserStyle =
  TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
  Widget build(BuildContext context){
    return Container(
      child: Column(
        children:<Widget>[
          Text("사용자 계정"),
          makeRow(Strings.Assets.RESTAURANT_JPG,"name"),

        ],
      ),
    );
  }
  Widget makeRow(String Path, String name){
    return Row(
      children:<Widget>[
        Container(
          child:Image.asset(Path,width:50,height:50),
          padding:EdgeInsets.all(5.0),
        ),
        Container(
          child: Text(name,style: UserStyle),
        ),
      ],
    );
  }
}