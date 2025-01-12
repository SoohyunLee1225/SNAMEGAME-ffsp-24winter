// import 'package:flutter/material.dart';
// import 'package:fssp_snakegame/snake_game.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fssp_snakegame/splash_screen.dart';
import 'dart:math';
import 'package:fssp_snakegame/server_api.dart';

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
                    // width: min(constraints.maxWidth*0.5, 900),
                    // height: min(constraints.maxHeight*0.5,400) ,
                    // fit: BoxFit.cover), //추후수정, 애니메이션 로고로 수정할 것임
                     width:constraints.maxWidth*0.8,
                    fit: BoxFit.scaleDown),
                    SizedBox(height: constraints.maxHeight*0.1), //추후 수정 필요
                    Text('FinaL Score : ${widget.score}', //깜빡이는 효과 넣어야함. 그렇다면 아예 GamestartInput에 넣는것도 좋을 것 같음(stateful이니까), container안에 넣으면.. 괜찮지않을까?
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

// class GameOver extends StatefulWidget{
//  // final int score = ;
//   // const GameOver({Key? key, required this.score}) : super(key: key);
//   const GameOver({super.key});
  
//   @override
//   _GameOverState createState() => _GameOverState();
// }

// class _GameOverState extends State<GameOver>{

//   // @override
//   // void initState(){
//   //   super.initState();
//   // }

//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       body: Center(
//         child: Container(
//           constraints: BoxConstraints(maxWidth: 1080), //최대 너비 제한
//           padding: EdgeInsets.all(16), //내부 여백 지정
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               Image.asset('assets/images/background.png'),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset('assets/images/GAME OVER.png'), //추후수정, 애니메이션 로고로 수정할 것임
//                   SizedBox(height: 0), //추후 수정 필요
//                   //Text('Final Score : ${widget.score}', 
//                   Text('Final Score : ', 
//                   style: TextStyle(
//                     fontSize: 30,
//                     fontFamily: 'SnaredrumZero'
//                   )
//                   ),
      

//                 ],
//               ),
//         //      GameStartInput(),
//             ],
//           )
          
//         )
//       ),
//     );
//   }
// }


