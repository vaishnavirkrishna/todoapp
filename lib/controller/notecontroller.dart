import 'package:hive/hive.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:practisetodo/model/notemodel.dart';

class NoteListController {
  List<NoteModel> dataList = [];
  final myBox = Hive.box('notebox');
  void addData(NoteModel newNote) {
    dataList.add(newNote);
    updateDb();
  }

  void deleteData(int index) {
    dataList.removeAt(index);
    updateDb();
  }

  loadData() async {
    final List dbData = myBox.get('noteDataList');
    dataList = dbData
        .map((element) => NoteModel(
            title: element, desc: element, date: element, clrIndex: element))
        .toList();
    print(dataList.length);
    print(dataList.first.clrIndex);
    print(dataList.first.title);
    print(dataList.first.desc);
    print(dataList.first.date);
  }

  void updateDb() {
    myBox.put('noteDataList', dataList);
  }
}
