import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holinoti_admin/constants/strings.dart' as Strings;

class UpperHalf extends StatelessWidget {
  final double appBarHeight;
  UpperHalf({this.appBarHeight = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height - appBarHeight) / 2,
      child: Image.asset(
        Strings.Assets.RESTAURANT_JPG,
        fit: BoxFit.cover,
      ),
    );
  }
}
