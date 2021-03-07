import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore,dart';

class AuthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  UserCredential _authResult;
  var _isSignUp = true;
  String _email;
  String _password;

  String _validateEmail(String value) {
    if (value.trim().isEmpty) return 'Please enter an email';
    return null;
  }

  String _validatePassword(String value) {
    if (value.trim().isEmpty) return 'Please enter a password';
    if (value.length < 8) return 'Password must be at least 8 characters';
    return null;
  }

  void _trySubmit() async {
    bool isValid = _formKey.currentState.validate();
    if (isValid) {
      _formKey.currentState.save();

      if (_isSignUp) {
        _authResult = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);

        await FirebaseFirestore.instance.collection('users').doc(_authResult.user.uid).catchError((error) => print('#### FIRESTORE PROBLEM : ' + error.toString()));

      } else {
        _authResult = await _auth.signInWithEmailAndPassword(email: _email, password: _password).catchError((error) => print('#### FIRESTORE PROBLEM : ' + error.toString()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              validator: _validateEmail,
              onSaved: (value) {
                _email = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: _validatePassword,
              onSaved: (value) {
                _password = value;
              },
            ),
            RaisedButton(
              onPressed: _trySubmit,
              child: _isSignUp ? Text('Sign Up') : Text('Log In'),
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  _isSignUp = !_isSignUp;
                });
              },
              child: Text('Existing user ? Log In!'),
            ),
          ],
        ),
      ),
    );
  }
}
