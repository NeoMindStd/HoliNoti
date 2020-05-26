import 'package:flutter/material.dart';
import 'package:holinoti_admin/constants/themes.dart';

class NoticeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Card(
        child: Container(
          child: Column(
            children: <Widget>[
              Text("Title", style: GlobalPage.blockTitle),
              Text("data", style: GlobalPage.blockContents),
            ],
          ),
        ),
      );
}
