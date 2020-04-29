import 'package:flutter/material.dart';
import 'package:holinoti_admin/constants/themes.dart' as Themes;

class MenuBlock extends StatelessWidget {
  final Widget title;
  final List<Widget> children;

  MenuBlock({this.title, this.children});

  @override
  Widget build(BuildContext context) => Container(
        margin: Themes.GlobalPage.blockMargin,
        padding: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: Themes.GlobalPage.boxBorder,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                      title ?? Container(),
                    ] +
                    children ??
                [],
          ),
        ),
      );
}
