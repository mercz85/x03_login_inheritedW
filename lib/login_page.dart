import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum formType { login, register }

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>(); //[formValidation]
  late String _email;
  late String _password;
  formType _formType = formType.login;

  bool validateAndSave() {
    //[formValidation] get form state to validate
    final form = formKey.currentState;
    //[formValidation] .save triggers onSave method in Form to set _email and _password
    form!.save();
    if (form.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      UserCredential userCredential;
      try {
        if (_formType == formType.login) {
          userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: _email, password: _password);
          print('LOGIN: ${userCredential.user!.uid}');
        } else {
          userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _email, password: _password);
          print('REGISTERED: ${userCredential.user!.uid}');
        }
      } catch (e) {
        print('ERROR: $e');
      }
    }
  }

  void moveToRegister() {
    formKey.currentState?.reset();

    setState(() {
      _formType = formType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState?.reset();
    setState(() {
      _formType = formType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter login demo')),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey, //[formValidation]
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buildInputs() + buildSubmitButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'email'),
        //[formValidation] use validator in TextFormField
        validator: (value) => value!.isEmpty ? 'email can´t be empty' : null,
        onSaved: (newValue) {
          _email = newValue!;
        },
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'password'),
        obscureText: true,
        validator: (value) => value!.isEmpty ? 'password can´t be empty' : null,
        onSaved: (newValue) {
          _password = newValue!;
        },
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == formType.login) {
      return [
        TextButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.resolveWith((states) => 4),
              backgroundColor: MaterialStateColor.resolveWith(
                  (states) => Colors.green[400]!)),
          onPressed: validateAndSubmit,
          child: const Text(
            'LOGIN',
            style: TextStyle(fontSize: 20),
          ),
        ),
        TextButton(
          onPressed: moveToRegister,
          child: const Text(
            'Create an account',
            style: TextStyle(
              fontSize: 20,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ];
    } else {
      return [
        TextButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.resolveWith((states) => 4),
              backgroundColor: MaterialStateColor.resolveWith(
                  (states) => Colors.green[400]!)),
          onPressed: validateAndSubmit,
          child: const Text(
            'REGISTER',
            style: TextStyle(fontSize: 20),
          ),
        ),
        TextButton(
          onPressed: moveToLogin,
          child: const Text(
            'Have an account? Login',
            style: TextStyle(
              fontSize: 20,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ];
    }
  }
}
