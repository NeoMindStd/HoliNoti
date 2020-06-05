import 'package:flutter/material.dart';
import 'package:holinoti_admin/bloc/settings_bloc.dart';
import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/constants/themes.dart' as Themes;
import 'package:holinoti_admin/screens/web_view.dart';
import 'package:holinoti_admin/screens/widgets/global/menu/menu_block.dart';
import 'package:holinoti_admin/screens/widgets/global/menu/menu_content.dart';
import 'package:holinoti_admin/screens/widgets/global/menu/menu_title.dart';
import 'package:holinoti_admin/utils/dialog.dart';
import 'package:holinoti_admin/utils/second_auth_manager.dart';

class SettingsPage extends StatelessWidget {
  final SettingsBloc _settingsBloc;

  SettingsPage(this._settingsBloc);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Themes.Colors.WHITE,
          title: const Text(
            Strings.SettingPage.SETTINGS,
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
                AppSetting(_settingsBloc),
                AppInfo(_settingsBloc),
                EtcSetting(_settingsBloc),
              ],
            ),
          ),
        ),
      );
}

class AppSetting extends StatelessWidget {
  final SettingsBloc _settingsBloc;

  AppSetting(this._settingsBloc);

  @override
  Widget build(BuildContext context) => MenuBlock(
        title: MenuTitle(Strings.SettingPage.APP_SETTING),
        children: <Widget>[
          MenuContent(Strings.SettingPage.ALARM_SETTING),
          MenuContent(Strings.SettingPage.SLEEP_TIME_SETTING),
          MenuContent(Strings.SettingPage.PASSWORD_FINGERPRINT_LOCK,
              onTap: () async {
            await SecondAuthManager().certify(context);
            // TODO 인증 상태에 따라 진행
          }),
          MenuContent(
            Strings.SettingPage.SHOW_TUTORIAL,
            onTap: () => AppDialog(context).showYesNoDialog(
              Strings.SettingPage.SHOW_TUTORIAL_DIALOG_YES_NO,
              onConfirm: _settingsBloc.initTutorial,
            ),
          ),
        ],
      );
}

class AppInfo extends StatelessWidget {
  final SettingsBloc _settingsBloc;

  AppInfo(this._settingsBloc);

  @override
  Widget build(BuildContext context) => MenuBlock(
        title: MenuTitle(Strings.SettingPage.APP_INFO),
        children: <Widget>[
          MenuContent(Strings.SettingPage.BUILD_VER),
          MenuContent(Strings.SettingPage.COMMUNITY_RULE),
          MenuContent(
            Strings.SettingPage.PRIVACY_POLICIES,
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WebViewPage(
                        Strings.SettingPage.PRIVACY_POLICIES,
                        Strings.HttpApis.PRIVACY_POLICIES))),
          ),
          MenuContent(
            Strings.SettingPage.OPEN_SRC_LICENSES,
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WebViewPage(
                        Strings.SettingPage.OPEN_SRC_LICENSES,
                        Strings.HttpApis.OPEN_SRC_LICENSES))),
          ),
        ],
      );
}

class EtcSetting extends StatelessWidget {
  final SettingsBloc _settingsBloc;

  EtcSetting(this._settingsBloc);

  @override
  Widget build(BuildContext context) => MenuBlock(
        title: MenuTitle(Strings.SettingPage.ETC),
        children: <Widget>[
          MenuContent(Strings.SettingPage.NOTICE),
          MenuContent(Strings.SettingPage.CONTACT),
        ],
      );
}
