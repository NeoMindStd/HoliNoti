// 알람 관련 설정
/*
로그인 설정 확인 후
나중에 푸시 알람 끼워넣을것

 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/*
class Alarm extends StatelessWidget{
  Widget build(BuildContext context){
    return OverlaySupport(
      child: MaterialApp(
        title:'Flutter Demo',
        home:Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed:(){
              showOverlayNotification((context){
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal:4),
                  child: SafeArea(
                    child:ListTile(
                      leading: SizedBox.fromSize(
                        size: const Size(40,40),
                        child: ClipOval(
                          child: Container(
                            color: Colors.black,
                          )
                        )
                      ),
                      title: Text('Demo Alram Title'),
                      subtitle: Text('Demo Alram Subtitle'),
                      trailing: IconButton(
                        icon: Icon(Icons.close),
                        onPressed:(){
                          OverlaySupportEntry.of(context).dismiss();
                        }
                      ),
                    ),
                  ),
                );
              }, duration: Duration(milliseconds:400));
            },
          )
        ),
      ),
    );
  }
}

*/
//지금은 그냥 리스트뷰인데 나중에 버튼형식으로 바꿀것
class AlramSetting extends StatelessWidget{
  Widget build(BuildContext context){
    final title = '알람 데모 모드';
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: ListView(
          children:<Widget>[
            ListTile(
              leading:Icon(Icons.map),
              title:Text('알람 이미지 1'),
            ),
            ListTile(
              leading:Icon(Icons.access_alarm),
              title:Text('알람 이미지 2'),
            ),
            ListTile(
              leading:Icon(Icons.accessibility_new),
              title:Text('알람 이미지 3')
            ),
            Container(
              child: Column(
                children:<Widget>[

                ]
              )
            )
          ],
        ),
      ),
    );
  }
}