import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:practisetodo/controller/notecontroller.dart';
import 'package:practisetodo/model/notemodel.dart';
import 'package:practisetodo/utils/color_constant.dart';
import 'package:practisetodo/view/carddetail.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NoteListController obj = NoteListController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime? _selectedDate;
  int? selectedIndex;
  int? index;
  List<NoteModel> todoList = [];
  final noteBox = Hive.box('notebox');
  late Future<void> _loadDataFuture;

  @override
  void initState() {
    super.initState();
    _loadDataFuture = loadDbData();
  }

  Future<void> loadDbData() async {
    todoList =
        List<NoteModel>.from(noteBox.get('noteDataList', defaultValue: []));
  }

  void saveTodo() {
    final newNote = NoteModel(
      title: nameController.text,
      desc: descController.text,
      date: dateController.text,
      clrIndex: selectedIndex!,
    );

    todoList.add(newNote);
    obj.addData(newNote);

    nameController.clear();
    descController.clear();
    dateController.clear();
    selectedIndex = 0;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateController.text) {
      setState(() {
        _selectedDate = picked;
        dateController.text = _selectedDate!.toLocal().toString().split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.deepPurpleAccent,
          centerTitle: true,
          title: Text(
            'TO-DO',
            style: TextStyle(color: Colors.black),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purpleAccent,
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: Colors.white,
              context: context,
              builder: (context) => Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 97, 216, 218),
                  borderRadius: BorderRadius.circular(30),
                ),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: "TITLE",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: descController,
                        decoration: InputDecoration(
                          labelText: "DESCRIPTION",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 40.0),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: dateController,
                        decoration: InputDecoration(
                          labelText: "DATE",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.date_range),
                            onPressed: () => _selectDate(context),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          height: 50,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: ColorConstant.myColorList.length,
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsetsDirectional.symmetric(
                                  horizontal: 5),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ColorConstant.myColorList[index],
                                      border: Border.all(
                                          width: 4,
                                          color: ColorConstant
                                              .myColorList[index])),
                                ),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancel"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                            ),
                          ),
                          Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              saveTodo();
                            },
                            child: Text("Save"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          child: Icon(
            Icons.add,
          ),
        ),
        body: FutureBuilder<void>(
          future: _loadDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                child: Column(
                  children: todoList.asMap().entries.map((entry) {
                    final index = entry.key;
                    final element = entry.value;

                    final title = element.title;
                    final description = element.desc;
                    final date = element.date;
                    final clrIndex = element.clrIndex;

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Mydetail(
                              title: title,
                              description: description,
                              date: date,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 5),
                            color: ColorConstant.myColorList[clrIndex],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          height: 200,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Spacer(),
                                    Center(
                                      child: Text(
                                        title,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        String message =
                                            'Title: $title\nDescription: $description\nDate: $date';

                                        Share.share(message);
                                        print(message);
                                      },
                                      icon: Icon(Icons.share),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        obj.deleteData(index);
                                        setState(() {
                                          todoList.removeAt(index);
                                        });
                                      },
                                      child: Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Align(
                                  alignment: AlignmentDirectional.topStart,
                                  child: Text(
                                    description,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Spacer(),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(date),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
