import 'package:flutter/material.dart';

class NotesDetailView extends StatefulWidget {
  @override
  _NotesDetailViewState createState() => _NotesDetailViewState();
}

class _NotesDetailViewState extends State<NotesDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes App"),
      ),
      body: Container(
        child: Text("The"),
      ),
    );
  }
}