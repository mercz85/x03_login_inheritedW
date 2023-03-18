import 'package:flutter/material.dart';

import 'auth.dart';

class AuthProvider extends InheritedWidget {
  const AuthProvider({Key? key, required Widget child, required this.auth})
      : super(key: key, child: child);

  //final Widget child;
  final BaseAuth auth;

  static AuthProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthProvider>();
  }

  @override
  bool updateShouldNotify(AuthProvider oldWidget) {
    return true;
  }
}
