import 'package:flutter/material.dart';
import 'package:holinoti_customer/bloc/profile_bloc.dart';
import 'package:holinoti_customer/constants/strings.dart' as Strings;
import 'package:holinoti_customer/constants/themes.dart' as Themes;

class AutoLoginPage extends StatelessWidget {
  final ProfileBloc _profileBloc;

  AutoLoginPage(this._profileBloc);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Themes.Colors.WHITE,
          title: const Text(
            Strings.ProfilePage.PERSONAL_INFO,
            style: TextStyle(
              color: Themes.Colors.ORANGE,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: IconThemeData(size: 28, color: Themes.Colors.ORANGE),
        ),
        body: Card(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("자동 로그인")),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: StreamBuilder<bool>(
                        initialData: _profileBloc.loginMode,
                        stream: _profileBloc.loginModeStream,
                        builder: (context, snapshot) {
                          return Switch(
                              value: snapshot.data,
                              onChanged: (loginMode) =>
                                  _profileBloc.loginMode = loginMode);
                          return SwitchListTile(
                            value: snapshot.data,
                            onChanged: (loginMode) =>
                                _profileBloc.loginMode = loginMode,
                            title: Text("자동로그인"),
                          );
//                return Text("자동로그인");
                        }),
                  )
                ],
              ),
              Text("사용으로 설정 시 앱이 켜질 때 자동으로 로그인 합니다."),
            ],
          ),
        ),
      );
}
