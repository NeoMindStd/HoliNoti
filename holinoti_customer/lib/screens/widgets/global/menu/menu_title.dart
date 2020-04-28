import 'package:flutter/material.dart';
import 'package:holinoti_customer/constants/themes.dart' as Themes;

class MenuTitle extends StatelessWidget {
  final String title;

  MenuTitle(this.title);

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(left: 10, top: 10),
        padding: const EdgeInsets.all(10),
        child: Text(
          title,
          style: Themes.GlobalPage.blockTitle,
        ),
      );
}
