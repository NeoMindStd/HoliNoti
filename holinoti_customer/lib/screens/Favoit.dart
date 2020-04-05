//즐겨찾기 관련 현재(20.04.06) 구현중
import 'package:flutter/material.dart';
import 'package:holinoti_customer/constants/strings.dart' as Strings;

class FavoritPage extends StatelessWidget {
  Widget build(BuildContext context){
    final title = '즐겨찾기 데모 모드';
    return MaterialApp(
        title: title,
        home: Scaffold(
          appBar: AppBar(title: Text(title)),
          body: ListView(
            children:<Widget>[
              ListTile(

                ),
              ListTile(
                leading:Icon(Icons.access_alarm),
                title:Text('즐겨찾기 이미지 2'),
                ),
              ListTile(
                leading:Icon(Icons.accessibility_new),
                title:Text('즐겨찾기 이미지 3')
                ),
              ],
          ),
        ),
    );
  }
}
class StoreProfile extends StatelessWidget{//상점 리스트출력 현재 구현중
  TextStyle UserStyle =
  TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
  Widget build(BuildContext context){
    return Container(
      child: Column(
        children:<Widget>[
          Text("상점"),
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