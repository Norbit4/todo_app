import 'package:hive/hive.dart';
import 'package:todo_app/model/note_model.dart';

class NoteAdapter extends TypeAdapter<NoteModel> {
  @override
  final typeId = 0;

  @override
  NoteModel read(BinaryReader reader) {
    return NoteModel(
      id: reader.read(),
      title: reader.read(),
      color: reader.read(),
      isChecked: reader.read(),
      text: reader.read(),
      date: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer.write(obj.id);
    writer.write(obj.title);
    writer.write(obj.color);
    writer.write(obj.isChecked);
    writer.write(obj.text);
    writer.write(obj.date);
  }
}
