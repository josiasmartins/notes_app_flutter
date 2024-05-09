import 'package:flutter/material.dart';
import 'package:notes_app/models/note_database.dart';
import 'package:notes_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

// import "./models/note_database.dart";
import "./pages/note_page.dart";

void main() async {
  // initialize note isar database

  WidgetsFlutterBinding.ensureInitialized();
  await NoteDataBase.initialize();

  runApp(
    MultiProvider(
      providers: [
        // Note provider
        ChangeNotifierProvider(create: (context) => NoteDataBase()),

        // Theme provider
        ChangeNotifierProvider(create: (context) => ThemeProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotePage(),
    );
  }
}
