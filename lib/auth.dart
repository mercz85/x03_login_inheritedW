import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  String? currentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);

    return userCredential.user!.uid;
  }

  @override
  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential.user!.uid;
  }

  @override
  String? currentUser() {
    User? user = firebaseAuth.currentUser;
    return user?.uid;
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
