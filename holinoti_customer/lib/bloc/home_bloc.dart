import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:holinoti_customer/bloc/facilities_bloc.dart';
import 'package:holinoti_customer/screens/facilities.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final _tapIndexSubject = PublishSubject<int>();
  get tapIndexStream => _tapIndexSubject.stream;

  void onTapChanged(int index) {
    _tapIndexSubject.add(index);
  }

  void moveToFacilitiesPage(
          BuildContext context, FacilitiesBloc facilitiesBloc) =>
      Navigator.push(
        context,
        platformPageRoute(
          context: context,
          builder: (context) => FacilitiesPage(facilitiesBloc),
        ),
      );
  //즐겨찾기 이동하는 버튼 구현할것
  /*void moveToFavoitPage(
      BuildContext context, FacilitiesBloc facilitiesBloc) =>
      Navigator.push(
        context,
        platformPageRoute(
          context: context,
          builder: (context) => FavoritPage(FavoritPage),
        ),
      );*/

  void dispose() {
    _tapIndexSubject.close();
  }
}
