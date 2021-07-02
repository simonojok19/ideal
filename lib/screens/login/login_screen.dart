import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peer2peer/services/firebase/FirebaseAuthenticationService.dart';

import '../../constants.dart';
import 'login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc _loginBloc;
  bool _showPassword = true;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(
      authenticationService: FirebaseAuthenticationService(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 2),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: size.height * .20, bottom: size.height * .15),
                  child: Center(
                    child: Text(
                      'LOGO',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: kPrimaryTextColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 40,
                          ),
                    ),
                  ),
                ),
                Text(
                  'Login',
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: kPrimaryTextColor),
                ),
                StreamBuilder<String>(
                  stream: _loginBloc.email,
                  builder: (context, snapshot) {
                    return Container(
                      margin: EdgeInsets.only(top: kDefaultPadding * 2),
                      padding:
                          EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: kPrimaryTextColor),
                        decoration: InputDecoration(
                          hintText: 'Email',
                          border: InputBorder.none,
                          hintStyle:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: kPrimaryTextColor.withOpacity(0.5),
                                  ),
                        ),
                        onChanged: _loginBloc.emailChanged.add,
                      ),
                      decoration: BoxDecoration(
                          color: kPrimaryDarkColor,
                          borderRadius: BorderRadius.circular(25)),
                    );
                  },
                ),
                StreamBuilder<String>(
                  stream: _loginBloc.password,
                  builder: (context, snapshot) {
                    return Container(
                      margin: EdgeInsets.only(top: kDefaultPadding * 2),
                      padding:
                          EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      child: TextField(
                        obscureText: _showPassword,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: kPrimaryTextColor),
                        decoration: InputDecoration(
                          hintText: 'Password',
                          border: InputBorder.none,
                          hintStyle:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: kPrimaryTextColor.withOpacity(0.5),
                                  ),
                          suffixIcon: Material(
                            color: kPrimaryDarkColor,
                            child: InkWell(
                              child: Icon(
                                _showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: kPrimaryTextColor,
                              ),
                              onTap: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                            ),
                          ),
                        ),
                        onChanged: _loginBloc.passwordChanged.add,
                      ),
                      decoration: BoxDecoration(
                          color: kPrimaryDarkColor,
                          borderRadius: BorderRadius.circular(25)),
                    );
                  },
                ),
                StreamBuilder<bool>(
                    stream: _loginBloc.enableLoginButton,
                    builder: (context, snapshot) {
                      return Container(
                        margin: EdgeInsets.only(top: kDefaultPadding * 2),
                        width: double.infinity,
                        height: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: MaterialButton(
                            onPressed: snapshot.data == true ? () {
                              _loginBloc.loginEmailAndPassword();
                            } : null,
                            child: Center(
                                child: Text(
                              'Login',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(color: kPrimaryTextColor),
                            )),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: snapshot.data == true ? kPrimaryLightColor : kPrimaryLightColor.withOpacity(.4),
                          borderRadius: BorderRadius.circular(25),
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }
}
