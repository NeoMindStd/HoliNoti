import 'package:flutter/material.dart';
import 'package:holinoti_admin/bloc/auth_bloc.dart';
import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/constants/enums.dart' as Enums;

class SignUpCard extends StatelessWidget {
  final AuthBloc _authBloc;

  SignUpCard(this._authBloc);

  @override
  Widget build(BuildContext context) {
    final TextEditingController accountController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController nameController = TextEditingController();

    final TextFormField accountField = TextFormField(
      decoration: InputDecoration(
          labelText: Strings.AuthPage.ACCOUNT,
          hasFloatingPlaceholder: true
      ),
      controller: accountController,
    );
    final TextFormField passwordField = TextFormField(
      decoration: InputDecoration(
          labelText: Strings.AuthPage.PASSWORD,
          hasFloatingPlaceholder: true
      ),
      controller: passwordController,
    );
    final TextFormField nameField = TextFormField(
      decoration: InputDecoration(
          labelText: Strings.GlobalPage.NAME,
          hasFloatingPlaceholder: true
      ),
      controller: nameController,
    );

    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      Strings.GlobalPage.SIGN_UP,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  accountField,
                  SizedBox(
                    height: 20,
                  ),
                  passwordField,
                  SizedBox(
                    height: 15,
                  ),
                  nameField,
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    Strings.AuthPage.PASSWORD_CONDITION,
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                      ),
                      FlatButton(
                        child: Text(Strings.GlobalPage.SIGN_UP),
                        color: Color(0xFF4B9DFE),
                        textColor: Colors.white,
                        padding: EdgeInsets.only(
                            left: 38, right: 38, top: 15, bottom: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () {
                          _authBloc.signUp(
                            account: accountController.text,
                            password: passwordController.text,
                            name: nameController.text,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              Strings.AuthPage.ALREADY_HAVE_YOU_AN_ACCOUNT,
              style: TextStyle(color: Colors.grey),
            ),
            FlatButton(
              onPressed: () { _authBloc.setAuthMode(Enums.AuthMode.signIn); },
              textColor: Colors.black87,
              child: Text(Strings.GlobalPage.SIGN_IN),
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: FlatButton(
            child: Text(
              Strings.AuthPage.TERMS_AND_CONDITION,
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}