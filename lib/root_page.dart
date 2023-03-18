import 'package:flutter/material.dart';
import 'package:x03_architecture/auth_provider.dart';
import 'package:x03_architecture/home_page.dart';
import 'login_page.dart';
import 'auth.dart';

class RootPage extends StatefulWidget {
  RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

enum AuthStatus { notSignedIn, signedIn }

class _RootPageState extends State<RootPage> {
  AuthStatus _authStatus = AuthStatus.notSignedIn;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var auth = AuthProvider.of(context)!.auth;
    String? userUId = auth.currentUser();
    setState(() {
      if (userUId != null) {
        _authStatus =
            userUId.isEmpty ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    //WE SHOULD NOT CALL dependOnInheritedWidgetOfExactType
    //from initState, like for example AuthProvider.of...
    //since at this stage the object is not fully initialized
    //so we do it from **didChangeDependencies**
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
          onSignedIn: _onSignedIn,
        );
      case AuthStatus.signedIn:
        return HomePage(onSignedOut: _onSignedOut);
    }
  }
}
