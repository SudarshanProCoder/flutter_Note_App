import 'package:flutter/material.dart';
import 'package:note_app/Models/note.dart';
import 'package:note_app/services/api_services.dart';

class NotesProvider with ChangeNotifier {

  bool isLoading = true;


  List<Note> notes = [];

  NotesProvider(){
    fetchNotes();
  }

  void addNote(Note note) {
    notes.add(note);
    notifyListeners();
    ApiService.addNote(note);
  }

  void UpdateNote(Note note) {
    int indexOfNote = notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note;
    notifyListeners();
    ApiService.addNote(note);
  }

  void DeleteNote(Note note) {
    int indexOfNote = notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote);
    notifyListeners();
    ApiService.deleteNote(note);
  }

  void fetchNotes() async{
    notes =  await ApiService.fetchNote("sudarshandate");
    isLoading = false;
    notifyListeners();

  }
}
