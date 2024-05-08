import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/note_database.dart';
import 'package:provider/provider.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  // text controller to access what the user typed
  final textController = TextEditingController();

  // create a note
  void createNote() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textController,
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    context.read<NoteDataBase>().addNotes(textController.text);

                    // pop dialog box
                    Navigator.pop(context);
                  },
                  child: const Text("Create"),
                )
              ],
            ));
  }

  // read notes
  void readNotes() {
    context.watch<NoteDataBase>().fetchNotes();
  }

  // upload a note

  // delete a note

  @override
  Widget build(BuildContext context) {
    // note data
    final noteDataBase = context.watch<NoteDataBase>();

    // current notes
    List<Note> currentNotes = noteDataBase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          "Notes",
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: currentNotes.length,
        itemBuilder: (context, index) {
          // get individual note
          final note = currentNotes[index];

          // list title UI
          return ListTile(
            title: Text(note.text),
          );
        },
      ),
    );
  }
}
