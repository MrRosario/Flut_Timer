import 'dart:async';
import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  @override
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  Timer _stopWatch;
  bool _isStarted = false;

  Color redClr = Colors.red;
  Color blackClr = Colors.black;
  Color greenLimeClr = Colors.green;

  String _stopLabel =  "PARAR";
  
  int min = 0;
  int seg = 0;
  

  void _startTime() {

    min %= 60;
    seg %= 60;

    setState(() {
      seg++;
      
      if(seg > 59){
        seg = 0;
        min += 1;
      } 
      
    });
    print('Minuts: $min');
    print('Seconds: $seg');
  }

  void _restartTime(){
    _stopWatch.cancel();
    _isStarted = false;
    
    setState(() {
      min = 0;
      seg = 0;

      _stopLabel = "PARAR";
      redClr = Colors.red;

    });
  }

  void _stopTime(){

    setState(() {
      _stopWatch.cancel();
      _stopLabel = "CONTINUAR";
      redClr = Colors.green;
    });

  }

  void _continueTime(){

    setState(() {
      _stopWatch = Timer.periodic(Duration(seconds: 1), (Timer time) => _startTime());
      _stopLabel = "PARAR";
      redClr = Colors.red;
    });
  
  }

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
              child: timeContainer(min, seg),
            )
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: buttonsContainer(_isStarted),
            )
          )
        ],
      )
    );
  }

  Widget buttonsContainer(bool _isStarted) {

    return Container(
      height: 60.0,
      decoration:  BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.black,
            width: 1.0
          ) 
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, 
        children: [
          _isStarted 
          ? textButtonCont() 
          : textButton("INICIAR", greenLimeClr),
      ]),
    );
  }

  Widget textButtonCont() {
    
    return Container(
      child: Row(
        children: [
          textButton(_stopLabel, redClr),
          textButton("REINICIAR", blackClr)
        ],
      ),
    );
  }

  Widget textButton(String title, Color btnColor) {
    return FlatButton(
      padding: EdgeInsets.all(8.0),
      onPressed: (){
        
        switch(title){
          case 'INICIAR':
            _isStarted = true;
            _stopWatch = Timer.periodic(Duration(seconds: 1), (Timer time) => _startTime());
            break;
          case 'PARAR': 
            _stopTime();
            break;
          case 'CONTINUAR': 
            _continueTime();
            break;  
          case 'REINICIAR':
            _restartTime(); 
        }
      },
      child: Text(
        title,
        style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: btnColor),
      ),
    );
  }

  Widget timeContainer(int min, int seg) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          timeItem(min),
          Text(":", style: TextStyle(color: Colors.black, fontSize: 60.0, fontWeight: FontWeight.bold )),
          timeItem(seg)
        ],
      ),
    );
  }

  Widget timeItem(int timeType) {
    return Text(
      timeType < 10 ? '0$timeType' : '$timeType',
      style: TextStyle(
        color: Colors.black, 
        fontSize: 70.0, 
        fontWeight: FontWeight.bold
      )
    );
  }
}
