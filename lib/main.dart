import 'package:flutter/material.dart';
import 'package:flut_timer/views/count_down.dart';
import 'package:flut_timer/views/stop_watch.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flut timer',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Text("Relogio"),
          bottom: TabBar(isScrollable: true, tabs: [
            Tab(icon: Icon(Icons.timer), text: "CRONÔMETRO"),
            Tab(icon: Icon(Icons.av_timer), text: "TEMPORIZADOR")
          ]),
        ),
        body: TabBarView(children: [StopWatch(), CountDown()]),
      ),
    );
  }
}
