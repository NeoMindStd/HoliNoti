import 'package:flutter/material.dart';
import 'package:holinoti_admin/constants/themes.dart' as Themes;
import 'package:holinoti_admin/screens/widgets/notice/notice_card.dart';

class NoticeListContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) => InkWell(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Title",
                  textAlign: TextAlign.left,
                  style: Themes.GlobalPage.blockTitle),
              Text("Content",
                  textAlign: TextAlign.left,
                  style: Themes.GlobalPage.blockContents),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text("date", textAlign: TextAlign.right),
                ],
              ),
            ],
          ),
        ),
        onTap: () {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: NoticeCard(),
          ));
        },
      );
}
