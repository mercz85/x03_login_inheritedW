import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>(); //[formValidation]
  late String _email;
  late String _password;

  bool validateAndSave() {
    //[formValidation] get form state to validate
    final form = formKey.currentState;
    //[formValidation] .save triggers onSave method in Form to set _email and _password
    form!.save();
    if (form!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() {
    if (validateAndSave()) {}
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
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'email'),
                //[formValidation] use validator in TextFormField
                validator: (value) =>
                    value!.isEmpty ? 'email can´t be empty' : null,
                onSaved: (newValue) {
                  _email = newValue!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'password'),
                obscureText: true,
                validator: (value) =>
                    value!.isEmpty ? 'password can´t be empty' : null,
                onSaved: (newValue) {
                  _password = newValue!;
                },
              ),
              TextButton(
                  style: ButtonStyle(
                      elevation:
                          MaterialStateProperty.resolveWith((states) => 4),
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.green[400]!)),
                  onPressed: validateAndSubmit,
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
