import 'package:flutter/material.dart';
import 'package:x03_architecture/home_page.dart';
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
    super.initState();
    //This user is persistent, so we retrieve it when the app starts
    String? userUId = widget.auth.currentUser();
    setState(() {
      if (userUId != null) {
        _authStatus =
            userUId.isEmpty ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      }
    });
  }

  void _onSignedIn() {
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
  }

  void _onSignedOut() {
    setState(() {
      _authStatus = AuthStatus.notSignedIn;
    });
    print('root');
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
        return HomePage(auth: widget.auth, onSignedOut: _onSignedOut);
    }
  }
}
