import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class NoteModel {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String color;

  @HiveField(3)
  late bool isChecked;

  NoteModel({
    required this.id,
    required this.title,
    required this.color,
    this.isChecked = false,
  });
}
