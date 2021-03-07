import 'package:flutter/material.dart';

class Note{
  String title;
  String category;
  String text;
  Note({this.title, this.category, this.text});
}

class UserModel{
  String name;
  String password;
  List<Note> notes;
  UserModel({this.name, this.password});
  void addNotes(Note note){
    this.notes.add(note);
  }
  void deleteNotes(String title){
    this.notes.removeWhere((item) => item.title == title);
  }
  String editNotes(String title, String newText){
    int indexOfNotes;
    int n = this.notes.length;
    for(int i = 0; i < n; i ++){
      if(this.notes[i].title == title){
        this.notes[i].text = newText;
      }
    }
  }
}