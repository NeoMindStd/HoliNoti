import 'package:flutter/material.dart';
import 'package:holinoti_customer/constants/strings.dart';

const TextStyle profileTitleText =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0);
const TextStyle profileButton = TextStyle(fontSize: 15.0);
const EdgeInsets profileMargin = EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0);

BoxDecoration boxBorder() {
  return BoxDecoration(
    border: Border.all(),
    borderRadius: BorderRadius.all(Radius.circular(25.0)),
  );
}

class profileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("개인 정보")),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              profileTitle(),
              profileList(),
            ],
          ),
        ),
      ),
    );
  }
}

//프로필
class profileTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: profileMargin,
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Image.asset("assets/tempimageS.jpg"), //프로필 사진
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("name", style: profileButton), //이름
                  Text(" / ", style: profileButton),
                  Text("email@email.com", style: profileButton), //이메일
                ],
              ),
              Row(
                children: <Widget>[
                  Text("id", style: profileButton), //사용자 id
                  Text(" / ", style: profileButton),
                  Text("010-0000-0000", style: profileButton), //전화번호
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//내용 출력
class profileList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: profileMargin,
      padding: const EdgeInsets.all(10.0),
      decoration: boxBorder(),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("  " + AuthPage.ACCOUNT, style: profileTitleText),
            FlatButton(
              onPressed: () {},
              child: Text("사업자 인증 및 신규 시설 등록", style: profileButton),
            ),
            FlatButton(
              onPressed: () {},
              child: Text("프로필 이미지 변경", style: profileButton),
            ),
            FlatButton(
              onPressed: () {},
              child: Text("이메일 변경", style: profileButton),
            ),
            FlatButton(
              onPressed: () {},
              child: Text("연락처 변경", style: profileButton),
            ),
            FlatButton(
              onPressed: () {},
              child: Text("비밀번호 변경", style: profileButton),
            ),
            FlatButton(
              onPressed: () {},
              child: Text("지문 변경", style: profileButton),
            ),
            FlatButton(
              onPressed: () {},
              child: Text("개인정보 공개 범위 설정", style: profileButton),
            ),
            FlatButton(
              onPressed: () {},
              child: Text("회원 탈퇴", style: profileButton),
            ),
            FlatButton(
              onPressed: () {},
              child: Text("로그아웃", style: profileButton),
            ),
          ],
        ),
      ),
    );
  }
}
