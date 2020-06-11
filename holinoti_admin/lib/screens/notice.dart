import 'package:flutter/material.dart';
import 'package:holinoti_admin/screens/widgets/notice/notice_list.dart';

class NoticeColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        child: NoticeList(),
      );
}

class NoticeList extends StatelessWidget {
  final size = [];

  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          NoticeListContent(),
        ],
      );
}
