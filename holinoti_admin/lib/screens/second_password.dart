import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holinoti_admin/bloc/second_password_bloc.dart';
import 'package:holinoti_admin/constants/enums.dart' as Enums;
import 'package:holinoti_admin/constants/themes.dart' as Themes;

class SecondPasswordPage extends StatelessWidget {
  final SecondPasswordBloc _secondPasswordBloc;

  SecondPasswordPage(this._secondPasswordBloc);

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Themes.Colors.ORANGE_DARK,
      appBar: AppBar(
        backgroundColor: Themes.Colors.ORANGE_DARK,
        elevation: 0,
        actions: <Widget>[
          StreamBuilder<Enums.SecondPassMode>(
            initialData: _secondPasswordBloc.initMode,
            stream: _secondPasswordBloc.initModeStream,
            builder: (context, snapshot) {
              assert(snapshot != null && snapshot.data!=null);
              return snapshot.data == Enums.SecondPassMode.verify ? MaterialButton(
                child: Text(
                    "비밀번호 초기화",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: ()=>_secondPasswordBloc.initPassword(context),
              ) :  Container();
            }
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                StreamBuilder<Enums.SecondPassMode>(
                initialData: _secondPasswordBloc.initMode,
                stream: _secondPasswordBloc.initModeStream,
                  builder: (context, snapshot) {
                    assert(snapshot != null && snapshot.data!=null);
                  String text = "";
                    if(snapshot.data == Enums.SecondPassMode.verify) {
                      text = "계속 진행하시려면\n간편 비밀번호를 입력해주세요.";
                    }
                    else if(snapshot.data == Enums.SecondPassMode.init) {
                      text = "새로운 간편 비밀번호를 입력해주세요.";
                    }
                    else {
                      text = "한번 더 입력해 주세요.";
                    }
                    return Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                        fontSize: 22,
                      ),
                    );
                  }
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                ),
                StreamBuilder<String>(
                  initialData: _secondPasswordBloc.inputPassword,
                  stream: _secondPasswordBloc.inputPasswordStream,
                  builder: (context, snapshot) {
                    assert(snapshot != null && snapshot.data != null);
                    String password = snapshot.data;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        6,
                            (index) => Icon(
                          Icons.lens,
                          size: 28,
                          color: password.length > index ? Colors.white : Themes.Colors.APRICOT,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GridView.count(
                childAspectRatio: 1.75,
                shrinkWrap: true,
                crossAxisCount: 3,
                children: List.generate(12, (index) {
                  Widget child;
                  Function onPressed;
                  switch (index) {
                    case 9:
                      child = Icon(
                        Icons.delete_forever,
                        color: Colors.white,
                        size: 32,
                      );
                      onPressed = () => _secondPasswordBloc.deletePassNum();
                      break;
                    case 10:
                      child = Text(
                          "0",
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                        ),
                      );
                      onPressed =
                          () => _secondPasswordBloc.addPassNum(context, (0));
                      break;
                    case 11:
                      child = Icon(
                        Icons.backspace,
                        color: Colors.white,
                        size: 32,
                      );
                      onPressed = () => _secondPasswordBloc.deletePassNum();
                      break;
                    default:
                      child = Text(
                        (index + 1).toString(),
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                        ),
                      );
                      onPressed = () =>
                          _secondPasswordBloc.addPassNum(context, (index + 1));
                      break;
                  }
                  return MaterialButton(
                    child: child ?? Container(),
                    onPressed: onPressed ?? () {},
                  );
                }),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(10),)
        ],
      ),
    );
}
