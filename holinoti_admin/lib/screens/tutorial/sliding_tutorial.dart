import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';
import 'package:holinoti_admin/bloc/tutorial_bloc.dart';
import 'package:holinoti_admin/screens/tutorial/page/left_home.dart';
import 'package:holinoti_admin/screens/tutorial/page/notice.dart';
import 'package:holinoti_admin/screens/tutorial/page/right_home.dart';

class SlidingTutorial extends StatelessWidget {
  final TutorialBloc _tutorialBloc;
  final ValueNotifier<double> notifier;
  final int pageCount;
  final _pageController = PageController(initialPage: 0);

  SlidingTutorial(this._tutorialBloc,
      {@required this.notifier, @required this.pageCount}) {
    _pageController
      ..addListener(
          () => _tutorialBloc.setCurrentPage(notifier, _pageController.page));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBackgroundColor(
      colors: [Colors.greenAccent, Colors.amber, Colors.pink],
      pageController: _pageController,
      pageCount: pageCount,
      child: Container(
        child: PageView(
          controller: _pageController,
          children: List<Widget>.generate(
              pageCount, (index) => _getPageByIndex(index)),
        ),
      ),
    );
  }

  Widget _getPageByIndex(int index) {
    switch (index % 3) {
      case 0:
        return LeftHomePage(index, notifier);
      case 1:
        return RightHomePage(index, notifier);
      case 2:
        return NoticePage(index, notifier);
      default:
        throw ArgumentError("Unknown position: $index");
    }
  }
}
