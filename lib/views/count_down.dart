import 'package:flutter/material.dart';

class CountDown extends StatefulWidget {
  @override
  _CountDownState createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("CONTAGEM REGRESSIVA", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),),
      ),
    );
  }
}
