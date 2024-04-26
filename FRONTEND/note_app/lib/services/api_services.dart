import 'dart:convert';
import 'dart:math';
// import 'dart:math';

import 'package:note_app/Models/note.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class ApiService{

  // ignore: prefer_final_fields
  static String _baseUrl = "https://notes-api-xi.vercel.app/notes";

  static Future<void> addNote(Note note) async{
    Uri requestUri = Uri.parse(_baseUrl + "/add");
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
  
  }

  static Future<void> deleteNote(Note note) async{
    Uri requestUri = Uri.parse(_baseUrl + "/delete");
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
  
  }

  static Future<List<Note>> fetchNote(String userid) async{
     Uri requestUri = Uri.parse(_baseUrl + "/list");
    var response = await http.post(requestUri, body: {"userid": userid});
    var decoded = jsonDecode(response.body);

  List<Note> notes = [];
    for(var noteMap in decoded){
      Note newNote = Note.fromMap(noteMap);
      notes.add(newNote); 
    }

    return notes;
  }

}