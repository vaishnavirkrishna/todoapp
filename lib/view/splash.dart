import 'package:flutter/material.dart';
import 'package:practisetodo/view/home_screen.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 5)).then((value) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://yt3.ggpht.com/a/AATXAJx7DIDW7oe0D3BW5_5WeFVtw9dXUiazAspN0n88hQ=s900-c-k-c0xffffffff-no-rj-mo"))),
    );
  }
}
