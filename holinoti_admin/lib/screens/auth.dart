import 'package:flutter/material.dart';
import 'package:holinoti_admin/bloc/auth_bloc.dart';
import 'package:holinoti_admin/constants/enums.dart' as Enums;
import 'package:holinoti_admin/screens/widgets/auth/page_title.dart';
import 'package:holinoti_admin/screens/widgets/auth/sigin_in_card.dart';
import 'package:holinoti_admin/screens/widgets/auth/sign_up_card.dart';
import 'package:holinoti_admin/screens/widgets/global/lower_half.dart';
import 'package:holinoti_admin/screens/widgets/global/upper_half.dart';

class AuthPage extends StatelessWidget {
  // To adjust the layout according to the screen size
  // so that our layout remains responsive ,we need to
  // calculate the screen height
  // Set initial mode to sign in

  final AuthBloc _authBloc;

  AuthPage(this._authBloc);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: StreamBuilder<Enums.AuthMode>(
                initialData: _authBloc.authMode,
                stream: _authBloc.isLoginModeStream,
                builder: (context, snapshot) {
                  return Stack(
                    children: <Widget>[
                      LowerHalf(),
                      UpperHalf(),
                      snapshot.data == Enums.AuthMode.signIn
                          ? SignInCard(_authBloc)
                          : SignUpCard(_authBloc),
                      PageTitle(),
                    ],
                  );
                }),
          ),
        ),
      );
}
