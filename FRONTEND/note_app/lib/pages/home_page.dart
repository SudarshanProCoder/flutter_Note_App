// ignore_for_file: use_super_parameters

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/Models/note.dart';
import 'package:note_app/pages/add_new_note.dart';
import 'package:note_app/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes App"),
        centerTitle: true,
      ),
      body: (notesProvider.isLoading == false) ? SafeArea(
        child: (notesProvider.notes.length > 0) ? GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: notesProvider.notes.length,
          itemBuilder: (context, index) {
            Note currentNote = notesProvider.notes[index];
            return GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    CupertinoPageRoute(builder: 
                      (context) => AddNewPage(isUpdate: true, note: currentNote,)
                    ),
                );
              },
              onLongPress: (){

                notesProvider.DeleteNote(currentNote);
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: 2)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentNote.title!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      currentNote.content!,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 240, 55, 55),
                        
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          },
        ): Center(
          child: Text("No notes yet"),
        ),
      ) : Center(
        child: CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => const AddNewPage(isUpdate: false,)));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
