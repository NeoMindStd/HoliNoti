import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  FavoriteButton({Key key}) : super(key: key);

  @override
  _FavoriteButton createState() => _FavoriteButton();
}

bool favorite = false; //즐겨찾기 버튼 관리

class _FavoriteButton extends State<FavoriteButton> {
  Widget build(BuildContext context) => IconButton(
        icon: Icon(
            (() {
              if (favorite == false || favorite == null) {
                // ignore: unnecessary_statements
                return Icons.favorite_border;
              } else {
                // ignore: unnecessary_statements
                return Icons.favorite;
              }
            }()),
            color: (() {
              if (favorite == false || favorite == null) {
                // ignore: unnecessary_statements
                return Colors.black;
              } else {
                // ignore: unnecessary_statements
                return Colors.red;
              }
            }())),
        onPressed: () {
          setState(() {
            // ignore: unnecessary_statements
            (() {
              if (favorite == false || favorite == null) {
                return favorite = true;
              } else {
                return favorite = false;
              }
            }());
          });
        },
      );
}
