import 'package:flutter/material.dart';
import 'package:holinoti_customer/bloc/auth_bloc.dart';
import 'package:holinoti_customer/constants/enums.dart' as Enums;
import 'package:holinoti_customer/screens/widgets/auth/login_card.dart';
import 'package:holinoti_customer/screens/widgets/auth/page_title.dart';
import 'package:holinoti_customer/screens/widgets/auth/register_card.dart';
import 'package:holinoti_customer/screens/widgets/global/lower_half.dart';
import 'package:holinoti_customer/screens/widgets/global/upper_half.dart';

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
                      snapshot.data == Enums.AuthMode.login
                          ? LoginCard(_authBloc)
                          : RegisterCard(_authBloc),
                      PageTitle(),
                    ],
                  );
                }),
          ),
        ),
      );
}
