import 'dart:async';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class CountDown extends StatefulWidget {
  @override
  _CountDownState createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {

  int _currentHour = 0;
  int _currentMin = 1;
  int _currentSec = 0;
  bool _isTimerOn = false;

  Timer _stopWatch;
  String _stopLabel =  "PAUSAR";
  bool _isStarted = false;

  Color redClr = Colors.red;
  Color blackClr = Colors.black;
  Color greenLimeClr = Colors.green;

  void _startTime() {
    _currentHour %= 100;
    _currentMin %= 60;
    _currentSec %= 60;

    setState(() {

      _isTimerOn = true;
      _currentSec--;
      
      if(_currentHour == 0 && _currentMin == 0 && _currentSec == 0){
        _currentHour = 0;
        _currentMin = 0;
        _currentSec = 0;
        _stopWatch.cancel();
        
        _isStarted = false;
        _isTimerOn = false;
      }

      if(_currentSec < 0){
        _currentSec = 59; 
        _currentMin--;
      }
      
      if(_currentMin < 0){
        _currentMin = 59;
        _currentHour--;
      }
    
    });
  }

  void _cancelTime(){
    _stopWatch.cancel();
    _isStarted = false;
    _isTimerOn = false;

    setState(() {
      _currentHour = 0;
      _currentMin = 0;
      _currentSec = 0;
       _stopLabel = "PAUSAR";
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
      _stopLabel = "PAUSAR";
      redClr = Colors.red;
    });
  
  }

  Decoration _decoration = new BoxDecoration(
    border: new Border(
      top: new BorderSide(
        style: BorderStyle.solid,
        color: Colors.black26,
      ),
      bottom: new BorderSide(
        style: BorderStyle.solid,
        color: Colors.black26,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white10,
      child: 
      Column(
        children: [
          Flexible(
            flex: 3,
            child: Align(
              alignment: Alignment.center,
              child: _isTimerOn 
                ? timeContainer(_currentHour, _currentMin, _currentSec)
                : timePickerTable(),
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
          textButton("CANCELAR", blackClr)
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
          case 'PAUSAR': 
            _stopTime();
            break;
          case 'CONTINUAR': 
            _continueTime();
            break;  
          case 'CANCELAR':
            _cancelTime(); 
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


  Widget timeContainer(int hour, int min, int sec) {
    return Container(
      width: double.infinity,
      height: 100.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          timeItem(hour),
          Text(
            ":", 
            style: TextStyle(
              color: Colors.black87, 
              fontSize: 65.0, 
              fontWeight: FontWeight.w300,
              fontFamily: 'Montserrat-Thin'
            )
          ),
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
          timeItem(sec)
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


  Widget timePickerTable(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              timeTypeTitle("Horas"),
              timeTypeTitle("Minutos"),
              timeTypeTitle("Segundos")
            ],
          ),
          SizedBox(height: 20.0),
          Container(
            decoration: _decoration,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                dataPicker(_currentHour, 99, "hour"),
                dataPicker(_currentMin, 59, "min"),
                dataPicker(_currentSec, 59, "sec")
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget timeTypeTitle(String title){
    return Text(
      title, 
      style: TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.w600,
        fontSize: 15.0
      ),
    );
  }

  Widget dataPicker(currentValue, maxValue, timeType){
    
    final theme = Theme.of(context);

    return Theme(
      data: Theme.of(context).copyWith(
        accentColor: Colors.green,
        textTheme: theme.textTheme.copyWith(
          headline5: TextStyle(
            fontSize: 30.0, 
            fontWeight: FontWeight.bold
          ),
          bodyText2: TextStyle(
            fontSize: 18.0, 
            fontWeight: FontWeight.w400, 
            color: Colors.grey
          ),
        )
      ),
      child: NumberPicker.integer(
        initialValue: currentValue,
        minValue: 0,
        maxValue: maxValue,
        zeroPad: true,
        infiniteLoop: true,
        onChanged: (newValue){
          setState((){
            switch(timeType){
              case "hour":
                _currentHour = newValue;
                break;
              case "min":
                _currentMin = newValue;
                break;
              case "sec":
                _currentSec = newValue;
                break;
              default: print("nada");
        
            }
          });
        }
      )
    );
  }
}
