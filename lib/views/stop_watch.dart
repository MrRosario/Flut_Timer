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
  int sec = 0;
  int milsec = 0;

  void _startTime() {

    min %= 60;
    sec %= 60;
    milsec %= 100;

    setState(() {
      milsec++;
      
      if(milsec > 99){
        milsec = 0;
        sec += 1;
      }

      if(sec > 59){
        sec = 0;
        min += 1;
      } 
      
    });
  }

  void _restartTime(){
    _stopWatch.cancel();
    _isStarted = false;
    
    setState(() {
      min = 0;
      sec = 0;
      milsec = 0;

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
      _stopWatch = Timer.periodic(Duration(milliseconds: 10), (Timer time) => _startTime());
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
          Flexible(
            flex: 3,
            child: Align(
              alignment: Alignment.center,
              child: timeContainer(min, sec),
            )
          ),
          Flexible(
            flex: 1,
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
            color: Colors.black26,
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
            _stopWatch = Timer.periodic(Duration(milliseconds: 10), (Timer time) => _startTime());
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
        style: TextStyle(
          fontSize: 22.0, 
          fontWeight: FontWeight.w500, 
          fontFamily: 'Montserrat-SemiBold',
          color: btnColor
        ),
      ),
    );
  }

  Widget timeContainer(int min, int sec) {
    return Container(
      width: double.infinity,
      height: 100.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          timeItem(min),
          Text(
            ":", 
            style: TextStyle(
              color: Colors.black87, 
              fontSize: 65.0, 
              fontWeight: FontWeight.w300,
              fontFamily: 'Montserrat-Thin'
            )
          ),
          timeItem(sec),
          Text(
            ".", 
            style: TextStyle(
              color: Colors.black87, 
              fontSize: 65.0, 
              fontWeight: FontWeight.w300,
              fontFamily: 'Montserrat-Thin'
            )
          ),
          timeItem(milsec)
        ],
      ),
    );
  }

  Widget timeItem(int timeType) {
    return Text(
      timeType < 10 ? '0$timeType' : '$timeType',
      style: TextStyle(
        color: Colors.black87, 
        fontSize: 65.0, 
        fontWeight: FontWeight.w100,
        letterSpacing: 4.0,
        fontFamily: 'Montserrat-Thin'
      )
    );
  }
}
