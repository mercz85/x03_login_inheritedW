import 'package:flutter/material.dart';
import 'login_page.dart';
import 'auth.dart';

class RootPage extends StatefulWidget {
  RootPage({Key? key, required this.auth}) : super(key: key);
  final BaseAuth auth;

  @override
  State<RootPage> createState() => _RootPageState();
}

enum AuthStatus { notSignedIn, signedIn }

class _RootPageState extends State<RootPage> {
  AuthStatus _authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    String userUId = widget.auth.currentUser();
    setState(() {
      _authStatus =
          userUId.isEmpty ? AuthStatus.notSignedIn : AuthStatus.signedIn;
    });
    super.initState();
  }

  void _onSignedIn() {
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.notSignedIn:
        return LoginPage(
          auth: widget.auth,
          onSignedIn: _onSignedIn,
        );
      case AuthStatus.signedIn:
        return Scaffold(
          body: SafeArea(
            child: Container(
              child: Text('Wellcome'),
            ),
          ),
        );
    }
  }
}
