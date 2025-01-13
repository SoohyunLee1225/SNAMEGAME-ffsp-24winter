import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fssp_snakegame/scoreboard.dart';
import 'package:fssp_snakegame/snake_game.dart';
import 'dart:math';


class SplashScreen extends StatelessWidget{
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: 
        Stack(
          alignment: Alignment.center,
          children: [
          Image.asset('assets/images/fallingbackground.gif', width: 1920, height: 1080, fit: BoxFit.cover),
          AspectRatio( aspectRatio: 4/3, 
          child:
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints){
              return
              Stack(
              alignment: Alignment.center,
              children: [
                
                Image.asset('assets/images/background.png',
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                fit: BoxFit.scaleDown,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/snakegame.gif',
                    width:constraints.maxWidth*0.8,
                      fit: BoxFit.scaleDown),
                    SizedBox(height: constraints.maxHeight*0.05),
                    Text('Press S for Scoreboard',
                    style: TextStyle(
                      fontSize: min(constraints.maxHeight*0.03, constraints.maxWidth*0.03),
                      fontFamily: 'SnaredrumZero',
                    )),
                    Text('Press X to Start', 
                    style: TextStyle(
                      fontSize: min(constraints.maxHeight*0.05, constraints.maxWidth*0.05),
                      fontFamily: 'SnaredrumZero'
                    )
                    ),
                    Text('Press Q to Quit',
                    style: TextStyle(
                      fontSize: min(constraints.maxHeight*0.05, constraints.maxWidth*0.05),
                      fontFamily: 'SnaredrumZero',
                    )),
                    
                    

                  ],
                ),
                GameStartInput(),
              ],
            );
            }
            
          )
        ),
          ]
      ))
    );
  }



}

class GameStartInput extends StatefulWidget{
  const GameStartInput({Key? key}) : super(key: key);

  @override
  _GameStartInput createState() => _GameStartInput();
}

class _GameStartInput extends State<GameStartInput> {
  final _focusNode = FocusNode();


  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose(){
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return KeyboardListener(
        focusNode: _focusNode, 
        onKeyEvent: (KeyEvent event){
          if (event is KeyDownEvent){
            if (event.logicalKey == LogicalKeyboardKey.keyX ){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GamePlay()),
              );

            }
            else if (event.logicalKey == LogicalKeyboardKey.keyQ){
              exit(0);
            }
            else if(event.logicalKey == LogicalKeyboardKey.keyS){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScoreBoard()),
              );
            } 
          }
        },
        
        
       child: Container());
    

  }
}


