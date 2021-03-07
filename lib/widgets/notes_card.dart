import 'package:flutter/material.dart';
import '../notes_detail_view.dart';

class NotesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Text("Hit me!"),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => NotesDetailView()));
        },
      )
    );
  }
}