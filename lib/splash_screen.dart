import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/services.dart';
import 'package:fssp_snakegame/snake_game.dart';

class SplashScreen extends StatelessWidget{
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 1080), //최대 너비 제한
          padding: EdgeInsets.all(16), //내부 여백 지정
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/images/background.png'),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/SNAKE GAME.png'), //추후수정, 애니메이션 로고로 수정할 것임
                  SizedBox(height: 0), //추후 수정 필요
                  Text('Press X to Start', //깜빡이는 효과 넣어야함. 그렇다면 아예 GamestartInput에 넣는것도 좋을 것 같음(stateful이니까), container안에 넣으면.. 괜찮지않을까?
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'SnaredrumZero'
                  )
                  ),
                  Text('Press Q to Quit',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'SnaredrumZero',
                  )),

                ],
              ),
              GameStartInput(),
            ],
          )
          
        )
      ),
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

  final String inputText ="";

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
                MaterialPageRoute(builder: (context) => SnakeGame()),
              );

            }
            else if (event.logicalKey == LogicalKeyboardKey.keyQ){
              Navigator.pop(context);
            } 
          }
        },
        
        
       child: Container());
    

  }
}


// class GameTitle extends StatefulWidget{
//   @override
//   _GameTitleState createState() => _GameTitleState();
// }

// class _GameTitleState extends State <GameTitle>{

// }


