import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Maps extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return WebviewScaffold(
      appBar: AppBar(
        title: Text("임시 카카오맵"),
      ),
      url: 'http://(IP주소):port/web',
      withJavascript: true,
      javascriptChannels: Set.from([
        JavascriptChannel(
          name:"jams",
          onMessageReceived: (JavascriptMessage result){
            print("message ${result.message}");
          }
        )
      ]),
    );
  }
}
