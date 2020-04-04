import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget{//로그인 구현
  State createState() => LoginState();
}

class LoginState extends State<Login>{//
  String userName = "";
  String password = "";
  Widget build(BuildContext context){
    return Center(
      child:Column(
        children:<Widget>[
          makeRowContainer('아이디',true),
          makeRowContainer('비밀번호',false),
          Container(child: RaisedButton(
              child: Text('로그인',style:TextStyle(fontSize: 21)),
              onPressed:(){
                if(userName =='dart'&&password=='flutter'){
                  setState((){
                    userName="";
                    password='';
                  });
                }
                else
                  Scaffold.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content:Text('일치하지 않습니다')));
              }
          ),
            margin:EdgeInsets.only(top:12),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  Widget makeRowContainer(String title, bool isUserName){
    return Container(
      child:Row(
        children:<Widget>[
          makeText(title),
          makeTextField(isUserName),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      padding:EdgeInsets.only(left: 60, right: 60, top:8, bottom: 8),
    );
  }
  Widget makeText(String title){
    return Text(
      title,
      style: TextStyle(
        fontSize:21,
        background:Paint()..color=Colors.green,
      ),
    );
  }
  Widget makeTextField(bool isUserName){
    return Container(
      child:TextField(
        controller:TextEditingController(),
        style: TextStyle(fontSize: 21, color: Colors.black),
        textAlign: TextAlign.center,
        decoration:InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide:BorderSide(
                color: Colors.red,
                width:2.0
            ),
          ),
          contentPadding:EdgeInsets.all(12),
        ),
        onChanged:(String str){
          if(isUserName)
            userName = str;
          else
            password=str;
        },
      ),
      width:200,
      padding: EdgeInsets.only(left: 16),
    );
  }
}
class BackHome extends StatelessWidget{
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:Text("로그인"),
      ),
      body:Center(
        child:RaisedButton(
          onPressed:(){
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
