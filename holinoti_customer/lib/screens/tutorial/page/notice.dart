import 'package:flutter/material.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';

class NoticePage extends StatelessWidget {
  final int page;
  final ValueNotifier<double> notifier;

  NoticePage(this.page, this.notifier);

  @override
  Widget build(BuildContext context) {
    return SlidingPage(
      page: page,
      notifier: notifier,
      child: Container(
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Center(
              child: SlidingContainer(
                  child: Image.asset(
                    "assets/tutorial/notice.png",
                  ),
                  offset: 300),
            ),
            Align(
              alignment: Alignment(0, 0.78),
              child: SlidingContainer(
                offset: 250,
                child: Text(
                  "알림 / 공지",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
