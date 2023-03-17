import 'package:flutter/material.dart';
import 'package:x03_architecture/auth.dart';
import 'package:x03_architecture/root_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.auth, required this.onSignedOut})
      : super(key: key);
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  void _signOut() {
    try {
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
              onPressed: _signOut,
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
