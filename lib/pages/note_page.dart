import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/components/drawer.dart';
import 'package:notes_app/components/note_tile.dart';
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

  @override
  void initState() {
    super.initState();

    readNotes();
  }

  // create a note
  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              context.read<NoteDataBase>().addNotes(textController.text);

              // celar controller
              textController.clear();

              // pop dialog box
              Navigator.pop(context);
            },
            child: const Text("Create"),
          ),
        ],
      ),
    );
  }

  // read notes
  void readNotes() {
    context.read<NoteDataBase>().fetchNotes();
  }

  // upload a note
  void updateNote(Note note) {
    // pre-fill the current note text
    textController.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text("Update Note"),
        content: TextField(controller: textController),
        actions: [
          // update button
          MaterialButton(
            onPressed: () {
              // update note in db
              context
                  .read<NoteDataBase>()
                  .updateNote(note.id, textController.text);
              // clear controller
              textController.clear();
              // pop dialog box
              Navigator.pop(context);
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  // delete a note
  void deleteNote(int id) {
    context.read<NoteDataBase>().deleteNotes(id);
  }

  @override
  Widget build(BuildContext context) {
    // note data
    final noteDataBase = context.watch<NoteDataBase>();

    // current notes
    List<Note> currentNotes = noteDataBase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        // title: Text(
        //   "Notes",
        //   style: TextStyle(color: Colors.white),
        // ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADING
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(
              "Notes",
              style: GoogleFonts.dmSerifText(
                fontSize: 48,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),

          // LIST OF NOTES
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context, index) {
                // get individual note
                final note = currentNotes[index];

                // list title UI
                return NoteTile(
                  text: note.text,
                  onEditPressed: () => updateNote(note),
                  onDeletePressed: () => deleteNote(note.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
