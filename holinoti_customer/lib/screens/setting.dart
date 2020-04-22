import 'package:flutter/material.dart';

const TextStyle settingTitle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0); //제목 폰트 설정
const TextStyle settingButton = TextStyle(fontSize: 15.0); //내용 폰트 설정
const EdgeInsets settingMargin =
    EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0); //상자 간격(시계방향)

BoxDecoration boxBorder() {
  //상자 디자인
  return BoxDecoration(
    border: Border.all(),
    borderRadius: BorderRadius.all(Radius.circular(25.0)),
  );
}

class settingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("설정")),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              appSetting(),
              appInfo(),
              etcSetting(),
            ],
          ),
        ),
      ),
    );
  }
}

//앱 설정 부분
class appSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: settingMargin,
      padding: const EdgeInsets.all(10.0),
      decoration: boxBorder(),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "  앱 설정",
              style: settingTitle,
            ),
            FlatButton(
              onPressed: () {},
              child: Text(
                "알림 설정",
                style: settingButton,
              ),
            ),
            FlatButton(
              onPressed: () {},
              child: Text(
                "방해금지 시간대 설정",
                style: settingButton,
              ),
            ),
            FlatButton(
              onPressed: () {},
              child: Text(
                "암호 / 지문 장금",
                style: settingButton,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//앱 정보 부분
class appInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: settingMargin,
        padding: const EdgeInsets.all(10.0),
        decoration: boxBorder(),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "  앱 정보",
                style: settingTitle,
              ),
              FlatButton(
                onPressed: () {},
                child: Text(
                  "빌드 버전",
                  style: settingButton,
                ),
              ),
              FlatButton(
                onPressed: () {},
                child: Text(
                  "커뮤니티 이용규칙",
                  style: settingButton,
                ),
              ),
              FlatButton(
                onPressed: () {},
                child: Text(
                  "개인정보 처리방침",
                  style: settingButton,
                ),
              ),
              FlatButton(
                onPressed: () {},
                child: Text(
                  "오픈소스 라이선스",
                  style: settingButton,
                ),
              ),
            ],
          ),
        ));
  }
}

//기타 부분
class etcSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: settingMargin,
        padding: const EdgeInsets.all(10.0),
        decoration: boxBorder(),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "  기타",
                style: settingTitle,
              ),
              FlatButton(
                onPressed: () {},
                child: Text(
                  "공지사항",
                  style: settingButton,
                ),
              ),
              FlatButton(
                onPressed: () {},
                child: Text(
                  "문의하기",
                  style: settingButton,
                ),
              ),
            ],
          ),
        ));
  }
}
