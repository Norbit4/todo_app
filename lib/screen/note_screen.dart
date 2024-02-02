import 'package:flutter/material.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({Key? key}) : super(key: key);

  @override
  CreateNoteScreenState createState() => CreateNoteScreenState();
}

class CreateNoteScreenState extends State<CreateNoteScreen> {
  String _title = '';
  String _text = '';
  Color? _backgroundColor = Colors.red[50];
  Color? _appBarColor = Colors.red[400];
  TextEditingController textController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  Widget colorButton(Color? backgroundColor, Color? appBarColor) {
    return GestureDetector(
      onTap: () async {
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
    int maxLengthText = 70;
    int maxLengthTitle = 25;

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
          const SizedBox(height: 35.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              colorButton(Colors.red[50], Colors.red[400]),
              colorButton(Colors.green[50], Colors.green[400]),
              colorButton(Colors.blue[50], Colors.blue[400]),
              colorButton(Colors.purple[50], Colors.purple[400]),
            ],
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 10, 30.0, 4.0),
            child: TextField(
              controller: titleController,
              onChanged: (text) async {
                setState(() {
                  _title = text;
                });
              },
              maxLength: maxLengthTitle,
              decoration: InputDecoration(
                labelText: 'Wpisz nazwę',
                counterText: '${titleController.text.length}/$maxLengthTitle',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 16, 20.0, 2.0),
            child: TextField(
              controller: textController,
              onChanged: (text) async {
                setState(() {
                  _text = text;
                });
              },
              maxLines: 2,
              maxLength: maxLengthText,
              decoration: InputDecoration(
                labelText: 'Wpisz opis',
                counterText: '${textController.text.length}/$maxLengthText',
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton.icon(
            onPressed: () {
              if (_title == '') {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text(' Zadanie musi mieć nazwę!'),
                  duration: const Duration(seconds: 1),
                  backgroundColor: _appBarColor,
                ));
                return;
              }
              createNote(_title, _appBarColor, _text);
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
