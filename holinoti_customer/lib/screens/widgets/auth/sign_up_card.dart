import 'package:flutter/material.dart';
import 'package:holinoti_customer/bloc/auth_bloc.dart';
import 'package:holinoti_customer/constants/enums.dart' as Enums;
import 'package:holinoti_customer/constants/strings.dart' as Strings;

class SignUpCard extends StatelessWidget {
  final AuthBloc _authBloc;
  final _formKey = GlobalKey<FormState>();

  SignUpCard(this._authBloc);

  @override
  Widget build(BuildContext context) {
    final TextEditingController accountController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController nameController = TextEditingController();

    final TextFormField accountField = TextFormField(
      decoration: InputDecoration(
        labelText: Strings.AuthPage.ACCOUNT,
        hasFloatingPlaceholder: true,
        suffixIcon: IconButton(
          icon: Icon(Icons.clear),
          onPressed: accountController.clear,
        ),
      ),
      controller: accountController,
      validator: (_) => null,
    );
    final passwordField = StreamBuilder<bool>(
      initialData: _authBloc.isObscureText,
      stream: _authBloc.isObscureTextStream,
      builder: (context, snapshot) => TextFormField(
        decoration: InputDecoration(
          labelText: Strings.AuthPage.PASSWORD,
          hasFloatingPlaceholder: true,
          suffixIcon: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // added line
            mainAxisSize: MainAxisSize.min, // added line
            children: <Widget>[
              IconButton(
                icon: Icon(
                    snapshot.data ? Icons.visibility_off : Icons.visibility),
                onPressed: _authBloc.switchObscureTextMode,
              ),
              IconButton(
                icon: Icon(Icons.clear),
                onPressed: passwordController.clear,
              ),
            ],
          ),
        ),
        controller: passwordController,
        obscureText: snapshot.data,
        validator: _authBloc.passwordValidator,
      ),
    );
    final TextFormField nameField = TextFormField(
      decoration: InputDecoration(
        labelText: Strings.GlobalPage.NAME,
        hasFloatingPlaceholder: true,
        suffixIcon: IconButton(
          icon: Icon(Icons.clear),
          onPressed: nameController.clear,
        ),
      ),
      controller: nameController,
      validator: (_) => null,
    );

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
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
                      height: 20,
                    ),
                    nameField,
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      Strings.AuthPage.passwordCondition,
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
                            if (_formKey.currentState.validate()) {
                              _authBloc.signUp(
                                account: accountController.text,
                                password: passwordController.text,
                                name: nameController.text,
                              );
                            }
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
                onPressed: () => _authBloc.setAuthMode(Enums.AuthMode.signIn),
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
      ),
    );
  }
}