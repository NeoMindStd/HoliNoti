import 'package:flutter/material.dart';
import 'package:holinoti_customer/bloc/profile_bloc.dart';
import 'package:holinoti_customer/constants/strings.dart' as Strings;
import 'package:holinoti_customer/constants/themes.dart' as Themes;
import 'package:holinoti_customer/screens/widgets/global/menu/menu_block.dart';
import 'package:holinoti_customer/screens/widgets/global/menu/menu_content.dart';
import 'package:holinoti_customer/screens/widgets/global/menu/menu_title.dart';
import 'package:holinoti_customer/utils/data_manager.dart';

class ProfilePage extends StatelessWidget {
  final ProfileBloc _profileBloc;

  ProfilePage(this._profileBloc);

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
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ProfileTitle(_profileBloc),
                ProfileList(_profileBloc),
              ],
            ),
          ),
        ),
      );
}

class ProfileTitle extends StatelessWidget {
  final ProfileBloc _profileBloc;

  ProfileTitle(this._profileBloc);

  @override
  Widget build(BuildContext context) => Container(
        margin: Themes.GlobalPage.blockMargin,
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Image.asset(Strings.Assets.TEMP_IMAGE_S), //프로필 사진
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(DataManager().currentUser.name,
                        style: Themes.GlobalPage.blockContents), //이름
                    Text(" / ", style: Themes.GlobalPage.blockContents),
                    Text(DataManager().currentUser.email,
                        style: Themes.GlobalPage.blockContents), //이메일
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(DataManager().currentUser.account,
                        style: Themes.GlobalPage.blockContents), //사용자 id
                    Text(" / ", style: Themes.GlobalPage.blockContents),
                    Text(DataManager().currentUser.phoneNumber,
                        style: Themes.GlobalPage.blockContents), //전화번호
                  ],
                ),
              ],
            ),
          ],
        ),
      );
}

class ProfileList extends StatelessWidget {
  final ProfileBloc _profileBloc;

  ProfileList(this._profileBloc);

  @override
  Widget build(BuildContext context) => MenuBlock(
        title: MenuTitle(Strings.AuthPage.ACCOUNT),
        children: <Widget>[
          MenuContent(
              Strings.ProfilePage.VERIFY_OWNER_AND_REGISTER_NEW_FACILITIES),
          MenuContent(Strings.ProfilePage.CHANGE_PROFILE_IMG),
          MenuContent(Strings.ProfilePage.CHANGE_EMAIL),
          MenuContent(Strings.ProfilePage.CHANGE_PHONE_NUMBER),
          MenuContent(Strings.ProfilePage.CHANGE_PASSWORD),
          MenuContent(Strings.ProfilePage.CHANGE_FINGERPRINT),
          MenuContent(Strings.ProfilePage.SET_DISCLOSURE_SCOPE_PERSONAL_INFO),
          MenuContent(Strings.ProfilePage.USER_SECESSION),
          MenuContent(
            Strings.GlobalPage.AUTO_LOGIN,
            onTap: () => _profileBloc.moveToAutoLoginPage(context),
          ),
          MenuContent(Strings.ProfilePage.LOGOUT),
        ],
      );
}
