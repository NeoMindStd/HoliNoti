import 'package:flutter/material.dart';
import 'package:holinoti_customer/constants/themes.dart' as Themes;

class MenuContent extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  final VoidCallback onDoubleTap;
  final VoidCallback onLongPress;
  final VoidCallback onTapCancel;

  MenuContent(
    this.name, {
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onTapCancel,
  });

  @override
  Widget build(BuildContext context) => InkWell(
        child: SizedBox(
          width: double.infinity,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              name,
              style: Themes.GlobalPage.blockContents,
            ),
          ),
        ),
        onTap: onTap ?? () {},
        onDoubleTap: onDoubleTap ?? () {},
        onLongPress: onLongPress ?? () {},
        onTapCancel: onTapCancel ?? () {},
      );
}
