import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fssp_snakegame/splash_screen.dart';
import 'dart:math';


class GameOver extends StatefulWidget{
  final int score;
  
 
  const GameOver({Key? key, required this.score}) : super(key: key);
  @override
  _GameOverState createState() => _GameOverState();
}

class _GameOverState extends State<GameOver>{
  final _focusNode = FocusNode();

  @override 
  void initState(){
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
    return Scaffold(
        body: Center(
          child: Stack(alignment: Alignment.center,
          children: [
            Image.asset('assets/images/fallingbackground.gif', width: 1920, height: 1080, fit: BoxFit.cover),
            AspectRatio(aspectRatio: 4/3, child:
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints){
              return  
          Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('assets/images/background.png',
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    fit: BoxFit.scaleDown),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/gameover.gif',
                     width:constraints.maxWidth*0.8,
                    fit: BoxFit.scaleDown),
                    SizedBox(height: constraints.maxHeight*0.1), 
                    Text('FinaL Score : ${widget.score}', 
                    style: TextStyle(
                      fontSize: min(constraints.maxHeight*0.05, constraints.maxWidth*0.05),
                      fontFamily: 'SnaredrumZero'
                    )
                    ),
                    Text('Enter to MainPage',
                    style: TextStyle(
                      fontSize: min(constraints.maxHeight*0.05, constraints.maxWidth*0.05),
                      fontFamily: 'SnaredrumZero',
                    )),

                  ],
                ),
            //    GameStartInput(),
              KeyboardListener(
                focusNode: _focusNode,
                onKeyEvent: (KeyEvent event){
                  if (event is KeyDownEvent){
                    if (event.logicalKey == LogicalKeyboardKey.enter){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SplashScreen())
                      );
                    }
                  }
                },
              
              
              
              child: Container())
              ],
            
            
          );
            }
        )
    ),]))
    );
  }



}


