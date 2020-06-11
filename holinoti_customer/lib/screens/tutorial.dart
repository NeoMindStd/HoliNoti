import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:holinoti_customer/bloc/tutorial_bloc.dart';
import 'package:holinoti_customer/screens/tutorial/sliding_tutorial.dart';

class TutorialPage extends StatelessWidget {
  final ValueNotifier<double> notifier = ValueNotifier(0);
  final TutorialBloc _tutorialBloc;
  final int pageCount = 3;

  TutorialPage(this._tutorialBloc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Stack(
        children: <Widget>[
          SlidingTutorial(
            _tutorialBloc,
            pageCount: pageCount,
            notifier: notifier,
          ),
          Align(
            alignment: Alignment(0, 0.85),
            child: Container(
              width: double.infinity,
              height: 0.5,
              color: Colors.white,
            ),
          ),
          Align(
            alignment: Alignment(0, 0.94),
            child: SlidingIndicator(
              indicatorCount: pageCount,
              notifier: notifier,
              activeIndicator: Icon(
                Icons.check_circle,
                size: 10,
                color: Color(0xFF29B6F6),
              ),
              inActiveIndicator: SvgPicture.asset(
                "assets/tutorial/hollow_circle.svg",
              ),
              margin: 8,
              sizeIndicator: 10,
            ),
          ),
          Align(
            alignment: Alignment(0.94, 0.98),
            child: FlatButton(
              child: StreamBuilder<double>(
                initialData: _tutorialBloc.currentPage,
                stream: _tutorialBloc.currentPageStream,
                builder: (context, snapshot) {
                  return Text(
                    _tutorialBloc.currentPage < pageCount - 1.5
                        ? "건너뛰기"
                        : "계속하기",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  );
                },
              ),
              onPressed: () => _tutorialBloc.moveToHomePage(context),
            ),
          ),
        ],
      )),
    );
  }
}
