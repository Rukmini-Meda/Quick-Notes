import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNote extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddNoteState();
  }
}

class _AddNoteState extends State<AddNote> {
  final _formKey = GlobalKey<FormState>();
  var user = FirebaseAuth.instance.currentUser;
  String _title;
  String _category;
  String _noteText;

  String _validate(String value) {
    if (value.isEmpty) return 'This value cannot be empty !';
    return null;
  }

  void _trySaving() {
    bool isValid = _formKey.currentState.validate();
    if (isValid) {
      _formKey.currentState.save();

      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('notes')
          .add({'title': _title, 'category': _category, 'noteText': _noteText});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _trySaving,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Title'),
              validator: _validate,
              onSaved: (value) {
                _title = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Category'),
              validator: _validate,
              onSaved: (value) {
                _category = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Note Text'),
              validator: _validate,
              onSaved: (value) {
                _noteText = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}
