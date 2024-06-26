import 'package:flutter/material.dart';
import 'package:todo_app/model/note_model.dart';
import '../widget/note_widget.dart';
import 'package:hive/hive.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  String? name = '';

  List<NoteWidget> notes = [];
  late Box<NoteModel> notesBox;

  @override
  void initState() {
    super.initState();
    loadNotes();
    loadName();
  }

  void loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? '';
    });
  }

  void loadNotes() async {
    notesBox = Hive.box<NoteModel>('tasks');
    notes = notesBox.values
        .map((note) => NoteWidget(
            id: note.id,
            title: note.title,
            color: Color(int.parse(note.color)),
            removeNote: removeNote,
            isChecked: note.isChecked,
            editNoteStatus: editNoteStatus,
            text: note.text,
            date: DateTime.parse(note.date)))
        .toList();

    notes.sort((a, b) => b.date.compareTo(a.date));
  }

  void removeNote(NoteWidget value) async {
    setState(() {
      notes.remove(value);
    });
    notesBox.delete(value.id);
  }

  String generateUniqueId(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
          length, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
  }

  void createNote(String title, Color color, String text) async {
    String id = generateUniqueId(6);
    DateTime now = DateTime.now();

    setState(() {
      notes.add(NoteWidget(
          id: id,
          title: title,
          color: color,
          removeNote: removeNote,
          isChecked: false,
          editNoteStatus: editNoteStatus,
          text: text,
          date: now));

      notes.sort((a, b) => b.date.compareTo(a.date));
    });

    final note = NoteModel(
        id: id,
        title: title,
        color: color.value.toString(),
        text: text,
        date: now.toString());

    notesBox.put(note.id, note);
  }

  void editNoteStatus(String noteId, bool isChecked) async {
    final note = notesBox.get(noteId);

    if (note != null) {
      note.isChecked = isChecked;
      notesBox.put(noteId, note);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        automaticallyImplyLeading: false,
        title: Text('Twoje zadania $name'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) => notes[index],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[600],
        onPressed: () {
          Navigator.pushNamed(context, '/note', arguments: createNote);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
