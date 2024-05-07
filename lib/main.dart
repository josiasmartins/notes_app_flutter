import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "./models/note_database.dart";

void main() async {
  // initialize note isar database

  WidgetsFlutterBinding.ensureInitialized();
  await NoteDataBase.initialize();

  runApp(ChangeNotifierProvider(create: (context) => NoteDataBase()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesPage(),
    );
  }
}
