import 'package:hive/hive.dart';
part 'notemodel.g.dart';

@HiveType(typeId: 1)
class NoteModel {
  @HiveField(0)
  String title;
  @HiveField(1)
  String desc;
  @HiveField(2)
  String date;
  @HiveField(3)
  int clrIndex;

  NoteModel({
    required this.title,
    required this.desc,
    required this.date,
    required this.clrIndex,
  });
}
