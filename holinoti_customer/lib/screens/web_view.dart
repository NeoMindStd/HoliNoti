import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holinoti_customer/constants/themes.dart' as Themes;

class WebViewPage extends StatelessWidget {
  final String title;
  final String url;

  const WebViewPage(this.title, this.url)
      : assert(title != null),
        assert(url != null);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: TextStyle(
                color: Themes.Colors.ORANGE, fontWeight: FontWeight.bold),
          ),
          iconTheme: IconThemeData(size: 28, color: Themes.Colors.ORANGE),
          backgroundColor: Themes.Colors.WHITE,
        ),
        body: EasyWebView(
          src: url,
          isHtml: false, // Use Html syntax
          isMarkdown: false, // Use markdown syntax
          convertToWidets: false, // Try to convert to flutter widgets
          // width: 100,
          // height: 100,
        ),
      );
}
