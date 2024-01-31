import 'package:flutter/material.dart';

class NoteWidget extends StatefulWidget {
  final String id;
  final String title;
  final Color color;
  final Function removeNote;
  final Function editNoteStatus;
  final bool isChecked;

  const NoteWidget({
    Key? key,
    required this.id,
    required this.title,
    required this.color,
    required this.removeNote,
    required this.isChecked,
    required this.editNoteStatus,
  }) : super(key: key);

  @override
  NoteWidgetState createState() => NoteWidgetState();
}

class NoteWidgetState extends State<NoteWidget> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double rectangleHeight = (screenHeight * 10) / 100;
    double rectangleWidth = (screenWidth * 50) / 100;
    double marginVertical = 12.0;
    double marginHorizontal = 17.0;

    return Container(
      height: rectangleHeight,
      width: rectangleWidth,
      margin: EdgeInsets.symmetric(
        vertical: marginVertical,
        horizontal: marginHorizontal,
      ),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Checkbox(
            value: isChecked,
            fillColor: MaterialStateProperty.all(Colors.black26),
            onChanged: (value) {
              setState(() {
                isChecked = value!;
                widget.editNoteStatus(widget.id, isChecked);
              });
            },
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    decoration: isChecked ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              widget.removeNote(widget);
            },
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
