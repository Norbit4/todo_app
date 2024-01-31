import 'package:flutter/material.dart';
import 'package:todo_app/model/note_adapter.dart';
import 'package:todo_app/screen/name_scren.dart';
import 'screen/note_screen.dart';
import 'screen/main_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'model/note_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<NoteModel>('notes');

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? name = prefs.getString('namesd');
  String initialRoute = '/name';

  if (name != null && name.isNotEmpty) {
    initialRoute = '/';
  }

  runApp(MyApp(initialRoute: initialRoute, name: name ?? ''));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  final String name;

  const MyApp({Key? key, required this.initialRoute, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: initialRoute,
      routes: {
        '/': (context) => MainScreen(name: name),
        '/name': (context) => const NameScreen(),
        '/note': (context) => const CreateNoteScreen(),
      },
    );
  }
}
