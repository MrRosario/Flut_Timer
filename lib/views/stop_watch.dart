import 'dart:ffi';

import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  @override
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white10,
        child: Column(
          children: [
            Expanded(
                child: Align(
              alignment: Alignment.center,
              child: Text("TEMPO"),
            )),
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: ButtonsContainer(),
            ))
          ],
        ));
  }
}

Widget ButtonsContainer() {
  final Color RedClr = Colors.red;
  final Color BlackClr = Colors.black12;
  final Color GreenClr = Colors.green;
  final Color GreenLimeClr = Colors.green[300];

  bool isStarted = false;

  return Container(
    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      isStarted ? textButton("INICIAR", GreenLimeClr) : textButtonCont(),
    ]),
  );
}

Widget textButton(String title, Color btnColor) {
  return FlatButton(
    textColor: btnColor,
    padding: EdgeInsets.all(8.0),
    onPressed: null,
    child: Text(
      title,
      style: TextStyle(fontSize: 20.0),
    ),
  );
}

Widget textButtonCont() {
  final Color RedClr = Colors.red;
  final Color BlackClr = Colors.black12;

  return Container(
    child: Row(
      children: [
        textButton("PARAR", RedClr),
        textButton("REINICIAR", BlackClr)
      ],
    ),
  );
}
