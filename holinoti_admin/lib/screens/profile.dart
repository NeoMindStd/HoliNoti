import 'package:flutter/material.dart';
import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/constants/themes.dart' as Themes;
import 'package:holinoti_admin/screens/widgets/global/menu/menu_block.dart';
import 'package:holinoti_admin/screens/widgets/global/menu/menu_content.dart';
import 'package:holinoti_admin/screens/widgets/global/menu/menu_title.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text(Strings.ProfilePage.PERSONAL_INFO)),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ProfileTitle(),
                ProfileList(),
              ],
            ),
          ),
        ),
      );
}

//프로필
class ProfileTitle extends StatelessWidget {
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
                    Text("name", style: Themes.GlobalPage.blockContents), //이름
                    Text(" / ", style: Themes.GlobalPage.blockContents),
                    Text("email@email.com",
                        style: Themes.GlobalPage.blockContents), //이메일
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("id", style: Themes.GlobalPage.blockContents), //사용자 id
                    Text(" / ", style: Themes.GlobalPage.blockContents),
                    Text("010-0000-0000",
                        style: Themes.GlobalPage.blockContents), //전화번호
                  ],
                ),
              ],
            ),
          ],
        ),
      );
}

//내용 출력
class ProfileList extends StatelessWidget {
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
          MenuContent(Strings.ProfilePage.LOGOUT),
        ],
      );
}
