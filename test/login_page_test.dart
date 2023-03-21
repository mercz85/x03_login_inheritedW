import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:x03_architecture/auth.dart';
import 'package:x03_architecture/auth_provider.dart';
import 'package:x03_architecture/login_page.dart';

/*    TESTS
*******************

GIVEN the email or password is empty
WHEN the user taps on the login button
THEN we don´t attempt to sign in with Firebase
AND the sign in callback is not called

GIVEN the email and password are both non-empty
AND they do match an account on Firebase
WHEN the suer taps on te login button
THEN we attempt to sign in with Firebase
AND the sign in callback is called

GIVEN the email and password are both non-empty
AND they do not match an account on Firebase
WHEN the user taps on the login button
THEN we attempt to sign in with Firebase
AND the sign in callback is not called
 
 */

//if we don use mockito, we should implement this class
class MockAuth implements BaseAuth {
  bool didAttemptSignIn = false;

  @override
  Future<String> createUserWithEmailAndPassword(String email, String password) {
    // TODO: implement createUserWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  String? currentUser() {
    // TODO: implement currentUser
    throw UnimplementedError();
  }

  @override
  Future<String> signInWithEmailAndPassword(String email, String password) {
    didAttemptSignIn = true;

    if (email == 'email' && password == 'password') {
      return Future.value('uid');
    } else {
      throw StateError('invalid credentials');
    }
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}

void main() {
//We use this (MaterialApp) to wrap our page with a MediaQuery ancestor
  Widget makeTestableWidget({required Widget child, required BaseAuth auth}) {
    return AuthProvider(
      //We don´t want to call to Firebase with Auth() so we create a mock
      auth: auth,
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets(
    'email or password is empty, does not sign in',
    (WidgetTester tester) async {
      MockAuth mockAuth = MockAuth();
      bool didSignIn =
          false; //To ckeck that the callback onSignedIn is NOT CALLED
      //Needs a MediaQuery ancestor because it hasnt Scaffold
      LoginPage page = LoginPage(onSignedIn: () => didSignIn = true);
      await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

      //Click on LOGIN button
      await tester.tap(find.byKey(const Key('signInBtn')));

      //signInWithEmailAndPassword should never be called due to our validate method
      expect(mockAuth.didAttemptSignIn, false);
      //the callback onSignedIn si not called
      expect(didSignIn, false);
    },
  );

  testWidgets(
    'non-empty email or password, valid account, does try to sign in and succeed',
    (WidgetTester tester) async {
      MockAuth mockAuth = MockAuth();
      bool didSignIn = false; //To ckeck that the callback onSignedIn IS CALLED
      //Needs a MediaQuery ancestor because it hasnt Scaffold
      LoginPage page = LoginPage(onSignedIn: () => didSignIn = true);
      await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

      //We fill email and pasword
      Finder emailFinder = find.byKey(const Key('emailTextFormField'));
      await tester.enterText(emailFinder, 'email');
      Finder passwordFinder = find.byKey(const Key('passwordTextFormField'));
      await tester.enterText(passwordFinder, 'password');

      //Click on LOGIN button
      await tester.tap(find.byKey(const Key('signInBtn')));

      //signInWithEmailAndPassword should be called
      // expect(mockAuth.signInWithEmailAndPassword('email', 'password'), Future<String>);
      expect(mockAuth.didAttemptSignIn, true);
      //the callback onSignedIn IS CALLED
      expect(didSignIn, true);

      ;
    },
  );

  testWidgets(
    'non-empty email or password, valid account, call sign in, failed',
    (WidgetTester tester) async {
      MockAuth mockAuth = MockAuth();
      bool didSignIn = false; //To ckeck that the callback onSignedIn IS CALLED
      //Needs a MediaQuery ancestor because it hasnt Scaffold
      LoginPage page = LoginPage(onSignedIn: () => didSignIn = true);
      await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

      //We fill email and pasword
      Finder emailFinder = find.byKey(const Key('emailTextFormField'));
      await tester.enterText(emailFinder, 'xx');
      Finder passwordFinder = find.byKey(const Key('passwordTextFormField'));
      await tester.enterText(passwordFinder, 'xx');

      //Click on LOGIN button
      await tester.tap(find.byKey(const Key('signInBtn')));

      //signInWithEmailAndPassword should be called
      expect(mockAuth.didAttemptSignIn, true);
      //the callback onSignedIn IS CALLED
      expect(didSignIn, false);

      ;
    },
  );
}
