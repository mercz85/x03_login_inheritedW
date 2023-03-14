import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  String currentUser();
}

class Auth implements BaseAuth {
  @override
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    return userCredential.user!.uid;
  }

  @override
  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential.user!.uid;
  }

  @override
  String currentUser() {
    User user = (FirebaseAuth.instance.currentUser!);
    return user.uid;
  }
}
