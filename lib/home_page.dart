import 'package:flutter/material.dart';

import 'auth_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.onSignedOut}) : super(key: key);
  final VoidCallback onSignedOut;

  void _signOut(BuildContext context) {
    try {
      var auth = AuthProvider.of(context)!.auth;

      auth.signOut();
      onSignedOut();
    } catch (e) {
      print('Error _signOut: ' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wellcome'),
        actions: [
          TextButton(
              onPressed: () => _signOut(context),
              child: const Text(
                'SignOut',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
              ))
        ],
      ),
      body: Container(
        child: const Center(
          child: Text(
            'WELLCOME',
            style: TextStyle(fontSize: 32),
          ),
        ),
      ),
    );
  }
}
