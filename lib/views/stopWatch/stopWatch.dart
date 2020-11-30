import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flut_timer/views/stopWatch/stopWatch_bloc.dart';

class StopWatch extends StatefulWidget {
  @override
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  
  StopWatchBloc bloc = StopWatchBloc();
  Color blackClr = Colors.black;
  Color greenLimeClr = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white10,
      child: StreamBuilder(
        stream: bloc.output,
        builder: (context, snapshot){
          return Column(
            children: [
              Flexible(
                flex: 3,
                child: Align(
                  alignment: Alignment.center,
                  child: timeContainer(bloc.min, bloc.sec),
                )
              ),
              Flexible(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: buttonsContainer(bloc.isStarted),
                )
              )
            ],
          );
        }

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
          textButton(bloc.stopLabel, bloc.redClr),
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
            bloc.isStarted = true;
            bloc.stopWatch = Timer.periodic(Duration(milliseconds: 10), (Timer time) => bloc.startTime());
            break;
          case 'PARAR': 
            bloc.stopTime();
            break;
          case 'CONTINUAR': 
            bloc.continueTime();
            break;  
          case 'REINICIAR':
            bloc.restartTime(); 
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
          timeItem(bloc.milsec)
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
