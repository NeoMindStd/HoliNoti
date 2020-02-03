import 'package:flutter/material.dart';
import 'package:holinoti_admin/constants/strings.dart' as Strings;

class PageTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            Strings.GlobalPage.APP_NAME_KR,
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}