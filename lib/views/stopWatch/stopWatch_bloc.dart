import 'dart:async';
import 'package:flutter/material.dart';

class StopWatchBloc {
  
  Timer stopWatch;
  bool isStarted = false;
  String stopLabel =  "PARAR";

  Color redClr = Colors.red;
  

  int min = 0;
  int sec = 0;
  int milsec = 0;

  final StreamController _streamController = StreamController();

  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  void startTime() {

    min %= 60;
    sec %= 60;
    milsec %= 100;

    milsec++;
    input.add(milsec);

    if(milsec > 99){
      milsec = 0;
      sec += 1;

      input.add(min);
    }

    if(sec > 59){
      sec = 0;
      min += 1;

      input.add(sec);
      input.add(min);
    } 
  }

  void restartTime(){
    stopWatch.cancel();
    isStarted = false;
    
    min = 0;
    sec = 0;
    milsec = 0;

    stopLabel = "PARAR";
    input.add(stopLabel);
    redClr = Colors.red;
  }

  void stopTime(){
    
    stopWatch.cancel();
    stopLabel = "CONTINUAR";
    input.add(stopLabel);
    redClr = Colors.green;

  }

  void continueTime(){
    stopWatch = Timer.periodic(Duration(milliseconds: 10), (Timer time) => startTime());
    stopLabel = "PARAR";
    
    redClr = Colors.red;
    input.add(stopLabel);
    
  }

  void dispose() {
    _streamController.close();
  }
}