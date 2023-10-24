import 'package:flutter/material.dart';

class Mydetail extends StatefulWidget {
  Mydetail(
      {super.key,
      required this.title,
      required this.description,
      required this.date});
  String? title;
  String? description;
  String? date;

  @override
  State<Mydetail> createState() => _MydetailState();
}

class _MydetailState extends State<Mydetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 192, 61, 125),
        centerTitle: true,
        title: Text(
          widget.title!,
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      backgroundColor: Colors.amberAccent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 148, 219, 229),
                      ),
                      height: 700,
                      width: 400,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.description!,
                                textAlign: TextAlign.justify,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  widget.date!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
