import 'package:flutter/material.dart';
import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/screens/widgets/global/menu/menu_block.dart';
import 'package:holinoti_admin/screens/widgets/global/menu/menu_content.dart';
import 'package:holinoti_admin/screens/widgets/global/menu/menu_title.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text(Strings.SettingPage.SETTINGS)),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppSetting(),
                AppInfo(),
                EtcSetting(),
              ],
            ),
          ),
        ),
      );
}

class AppSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MenuBlock(
        title: MenuTitle(Strings.SettingPage.APP_SETTING),
        children: <Widget>[
          MenuContent(Strings.SettingPage.ALARM_SETTING),
          MenuContent(Strings.SettingPage.SLEEP_TIME_SETTING),
          MenuContent(Strings.SettingPage.PASSWORD_FINGERPRINT_LOCK),
        ],
      );
}

class AppInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MenuBlock(
        title: MenuTitle(Strings.SettingPage.APP_INFO),
        children: <Widget>[
          MenuContent(Strings.SettingPage.BUILD_VER),
          MenuContent(Strings.SettingPage.COMMUNITY_RULE),
          MenuContent(Strings.SettingPage.PRIVACY_POLICIES),
          MenuContent(Strings.SettingPage.OPEN_SRC_LICENSES),
        ],
      );
}

class EtcSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MenuBlock(
        title: MenuTitle(Strings.SettingPage.ETC),
        children: <Widget>[
          MenuContent(Strings.SettingPage.NOTICE),
          MenuContent(Strings.SettingPage.CONTACT),
        ],
      );
}
