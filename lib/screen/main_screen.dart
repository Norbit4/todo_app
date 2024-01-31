import 'package:flutter/material.dart';
import 'package:todo_app/model/note_model.dart';
import '../widget/note_widget.dart';
import 'package:hive/hive.dart';
import 'dart:math';

class MainScreen extends StatefulWidget {
  final String name;

  const MainScreen({Key? key, required this.name}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  List<NoteWidget> notes = [];
  late Box<NoteModel> notesBox;

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  void loadNotes() async {
    notesBox = Hive.box<NoteModel>('notes');
    notes = notesBox.values
        .map((note) => NoteWidget(
              id: note.id,
              title: note.title,
              color: Color(int.parse(note.color)),
              removeNote: removeNote,
              isChecked: note.isChecked,
              editNoteStatus: editNoteStatus,
            ))
        .toList();
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

  void createNote(String title, Color color) async {
    String id = generateUniqueId(6);

    setState(() {
      notes.add(NoteWidget(
          id: id,
          title: title,
          color: color,
          removeNote: removeNote,
          isChecked: false,
          editNoteStatus: editNoteStatus));
    });

    final note = NoteModel(id: id, title: title, color: color.value.toString());

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
        title: Text('Twoje zadania ${widget.name}'),
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
