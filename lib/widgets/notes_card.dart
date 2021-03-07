import 'package:flutter/material.dart';
import 'package:notes_app/screens/notes_detail_view.dart';

class NotesCard extends StatelessWidget {
  final String title, category;
  NotesCard({this.title, this.category});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: InkWell(
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.lightBlue[100],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[200],
                  blurRadius: 15.0,
                  spreadRadius: 15.0,
                  offset: Offset(
                    2.0,
                    3.0
                  )
                ),
              ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(title, style: TextStyle( fontWeight: FontWeight.bold,fontSize: 40),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(category, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                )
              ],
            ),
          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => NotesDetailView()));
          },
        )
      ),
    );
  }
}