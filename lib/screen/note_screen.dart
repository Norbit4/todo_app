import 'package:flutter/material.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({Key? key}) : super(key: key);

  @override
  CreateNoteScreenState createState() => CreateNoteScreenState();
}

class CreateNoteScreenState extends State<CreateNoteScreen> {
  String _title = '';
  Color? _backgroundColor = Colors.red[50];
  Color? _appBarColor = Colors.red[400];

  Widget colorButton(Color? backgroundColor, Color? appBarColor) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _backgroundColor = backgroundColor;
          _appBarColor = appBarColor;
        });
      },
      child: Container(
        width: 40,
        height: 40,
        color: appBarColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Function createNote =
        ModalRoute.of(context)!.settings.arguments as Function;
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _appBarColor,
        title: const Text('Nowe zadanie'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (text) {
                setState(() {
                  _title = text;
                });
              },
              decoration: const InputDecoration(labelText: 'Wpisz nazwę'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              colorButton(Colors.red[50], Colors.red[400]),
              colorButton(Colors.green[50], Colors.green[400]),
              colorButton(Colors.blue[50], Colors.blue[400]),
              colorButton(Colors.purple[50], Colors.purple[400]),
            ],
          ),
          const SizedBox(height: 16.0),
          ElevatedButton.icon(
            onPressed: () {
              if (_title == '') {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('Notatka musi mieć nazwę!'),
                  duration: const Duration(seconds: 1),
                  backgroundColor: _appBarColor,
                ));
                return;
              }
              createNote(
                _title,
                _appBarColor,
              );
              Navigator.pop(context);
            },
            icon: const Icon(Icons.save),
            label: const Text('Zapisz'),
            style: ElevatedButton.styleFrom(
              backgroundColor: _appBarColor,
              minimumSize: const Size(120, 40),
            ),
          ),
        ],
      ),
    );
  }
}
