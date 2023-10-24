import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:practisetodo/model/notemodel.dart';

import 'package:practisetodo/view/splash.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox('notebox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyWidget());
  }
}
