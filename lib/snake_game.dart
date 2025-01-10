import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fssp_snakegame/gameover_score.dart';
import 'package:fssp_snakegame/server_api.dart';
//import 'package:fssp_snakegame/splash_screen.dart';

enum Direction {
  up(Offset(0, 1)),
  down(Offset(0, -1)),
  left(Offset(-1, 0)),
  right(Offset(1, 0));

  final Offset offset;
  const Direction(this.offset);

   Direction applyMultiplier(int multiplier) {
    if (multiplier == -1) {
      return _getOpposite(); // 반대 방향 반환
    }
    if (multiplier == 1) {
      return this; // 현재 방향 유지
    }
    throw ArgumentError("Only 1 or -1 are supported as multipliers.");
  }

  // 반대 방향 반환 메서드
  Direction _getOpposite() {
    switch (this) {
      case Direction.up:
        return Direction.down;
      case Direction.down:
        return Direction.up;
      case Direction.left:
        return Direction.right;
      case Direction.right:
        return Direction.left;
    }
  }
}




class GamePlay extends StatelessWidget{
  const GamePlay({super.key});

  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: 
          LayoutBuilder(
            builder:(BuildContext context, BoxConstraints constraints){
              return Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/images/background.png',
                  width: constraints.maxWidth*0.8,
                  height: constraints.maxHeight*0.8,
                  fit: BoxFit.none),
                  Container(
                //    top: constraints.maxHeight*0.2,
                    child: SizedBox(
                      width: min(400, constraints.maxWidth-100), 
                      height: min(400, constraints.maxHeight-100), 
                      child: SnakeGame(),))
                  
                  
                ],
              );
            } 
          )
        //   child: Stack(
        //     alignment: Alignment.center,
        //     children: [
        //       Image.asset('assets/images/background.png'),
        //       Positioned(
        //         top: 0.5*context.height,
        //         child: SizedBox(
        //           width:600,
        //           height: 500, 
        //           child: SnakeGame()))
              
             
                  
                    
                    
        //           ],
                  
                
              
              
  
        // ),
      )
    );
  

  }
}

class SnakeGame extends StatefulWidget{
  @override
  _SnakeGameState createState() => _SnakeGameState();
}

class _SnakeGameState extends State<SnakeGame> {

  static const int gridSize=20;
  static int screenSize=400;
 // static  int gridCount= screenSize ~/ gridSize;
  static const double initialSpeed = 250.0;
  double cellSize = 20.0;
  
  late double snakeSpeed;

  List<Offset> snake = [Offset(10,10), Offset(10,11), Offset(10,12 ), Offset(10,13), Offset(10,14)];
  Offset food = Offset(5, 10);
  Direction direction = Direction.up;
  Direction keyboardDirection = Direction.up;
  Timer? countdowntimer;
  Timer? timer;
  int score = 0;
  bool isGameRunning = false;

  int countdown = 3;

  FocusNode _focusNode = FocusNode();
  Offset inputoffset = Offset(0, 0);

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    startCountdown();
  }
  
  String get asScore => "$score";


  void startCountdown() {
    countdown=3;
    countdowntimer= Timer.periodic(Duration(seconds: 1), (Timer countdowntimer) {
      setState(() {
        countdown--; // 카운트다운 감소
        Text('$countdown', style: TextStyle(
          fontFamily: 'SnaredrumZero',
          fontSize: 50,
          color: Colors.black
        ),);
      });

      if (countdown == 0) {
        countdowntimer.cancel(); // 카운트다운 종료
        startGame(); // 게임 시작
        
      }
    });
  }

  void startGame(){
    if (!isGameRunning){
      setState(() {
        isGameRunning = true;
        snake = [Offset(10,10), Offset(10,11), Offset(10,12), Offset(10,13), Offset(10,14)];
        snakeSpeed = initialSpeed;
        direction = Direction.up;
        score=0;
        generateFood();
        timer = Timer.periodic(Duration(milliseconds: snakeSpeed.toInt()), 
        (Timer t){
          print("$isGameRunning.1");
          moveSnake();
          checkCollision();
        });
      });
    }
  }

  void generateFood(){ // 음식 위치를 랜덤으로 생성하고, 만약 음식 위치가 뱀과 겹친다면 다시 생성
    final Random rand = Random();
    Offset newFood;
    do{
      newFood = Offset(
        rand.nextInt(gridSize).toDouble(),
        rand.nextInt(gridSize).toDouble()
      );
    } while(snake.contains(newFood));
    
    food=newFood;

  }

  void moveSnake(){
    setState(() {
      switch (direction){
        case Direction.up:
          snake.insert(0, Offset(snake.first.dx, snake.first.dy-1));
          break;
        case Direction.down:
          snake.insert(0, Offset(snake.first.dx, snake.first.dy+1));
          break;
        case Direction.left:
          snake.insert(0, Offset(snake.first.dx-1, snake.first.dy));
          break;
        case Direction.right:
          snake.insert(0, Offset(snake.first.dx+1, snake.first.dy));
          break;
      }

      if (snake.first==food){
        generateFood();
        score=score+100;
        if(score>=500){
          snakeSpeed *= 0.95;
          }
        timer?.cancel();
        timer = Timer.periodic(Duration(milliseconds: snakeSpeed.toInt()), 
        (Timer t){
          moveSnake();
          checkCollision();
        }
        );
      } else{
        snake.removeLast();
      }
    });

  }

  void checkCollision(){
    if (snake.first.dx<0 ||
        snake.first.dx>=gridSize ||
        snake.first.dy<0 ||
        snake.first.dy>=gridSize ||
        snake.sublist(3).contains(snake.first)){
          stopGame();
          //gameOver();
        }
  }

  void stopGame(){
    setState(() {
      isGameRunning = false;
      timer?.cancel();
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => GameOver()),
      // );

      //GameOver(score:score);
      // Future.microtask((){
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => GameOver(score: score),
      //     )
      //   );
      // }
      // );
      sendScoreToServer(score);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GameOver(score: score),
      ),
      );
    }
    );
  }

  void wasd(KeyEvent event){
    switch(event.physicalKey){
      case PhysicalKeyboardKey.keyW:
        keyboardDirection = Direction.up;
        break;
      case PhysicalKeyboardKey.keyS:
        keyboardDirection = Direction.down;
        break;
      case PhysicalKeyboardKey.keyA:
        keyboardDirection = Direction.left;
        break;
      case PhysicalKeyboardKey.keyD:
        keyboardDirection = Direction.right;
        break;
    }

  }



  @override
  Widget build(BuildContext context){
 //   screenSize=MediaQuery.of(context).size.width.toInt()-300;
 //   cellSize = screenSize / gridSize;
   return 
   LayoutBuilder(builder: (BuildContext context, BoxConstraints
   constraints){
   // final maxConstraints = BoxConstraints(maxHeight: 400, maxWidth: 400);
    //  double screenSize = min(constraints.maxHeight, constraints.maxWidth);
      cellSize = screenSize / gridSize;
    
      return Stack(
        alignment: Alignment.center,
        // width: screenSize.toDouble()+100.0,
        // height: screenSize.toDouble()+100.0,
        children: [
          // SizedBox(
          // width: screenSize.toDouble()+100.0,
          // height: screenSize.toDouble()+100.0,
          // child: 
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
              child: SizedBox(
                width: screenSize.toDouble(),
                height: screenSize.toDouble(),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.pinkAccent,
                      width: 1.0,
                    )
                  ),
                  width: screenSize.toDouble(),
                  child: 
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return 
                      KeyboardListener(focusNode: _focusNode, 
                      onKeyEvent: (KeyEvent event){
                        if(!isGameRunning) return;
                        switch(event.physicalKey){
                          // case PhysicalKeyboardKey.keyX:
                          //   startGame();
                          //   break;
                          case PhysicalKeyboardKey.keyW:
                            if(direction!=Direction.down){
                              direction=Direction.up;
                            }
                            break;
                          case PhysicalKeyboardKey.keyS:
                            if(direction!=Direction.up){
                              direction=Direction.down;
                            }
                            break;
                          case PhysicalKeyboardKey.keyA:
                            if(direction!=Direction.right){
                              direction=Direction.left;
                            }
                            break;
                          case PhysicalKeyboardKey.keyD:
                            if(direction!=Direction.left){
                              direction=Direction.right;
                            }
                            break;
                        }
                      },
                      child: Stack(
                          children: [
                            CustomPaint(
                              painter: BoundaryPainter(gridSize, cellSize),
                              size:
                                  Size(constraints.maxWidth, constraints.maxWidth),
                                  //Size(_screenSize, _screenSize),
                            ),
                            CustomPaint(
                              painter:
                                  SnakePainter(snake, food, gridSize, cellSize),
                              size:
                                 Size(constraints.maxWidth, constraints.maxWidth),
                                 //Size(_screenSize, _screenSize),
                            ),
                          ],                    
                      ),            
                    );
                    },
                ),
                )  
              )
            ),
            
            
            ],
       //   )
       
          ),
          Positioned(
              left: -250,
              top: 400,
              child: Text('$score',
                            style: TextStyle(fontFamily: 'SnaredrumTwo', fontSize: 50),
                            ),
              ),
        ]
      );
    }
    );
    
  }

}

class SnakePainter extends CustomPainter {
  final List<Offset> snake;
  final Offset food;
  final int gridSize;
  final double cellSize;
 

  SnakePainter(this.snake, this.food, this.gridSize, this.cellSize);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint foodPaint = Paint()
      ..color = Colors.pinkAccent;

      

    // Draw snake with gradient per segment
    for (int i = 0; i < snake.length; i++) {
      double progress = i / (snake.length - 1); // 0.0 (머리) ~ 1.0 (꼬리)
      Color segmentColor = Color.lerp(Colors.lightGreenAccent, const Color.fromARGB(255, 219, 255, 177), progress)!;

      final Paint segmentPaint = Paint()..color = segmentColor;

      Offset position = snake[i];
      canvas.drawRect(
          Rect.fromPoints(
            Offset(position.dx * cellSize, position.dy * cellSize),
            Offset((position.dx + 1) * cellSize, (position.dy + 1) * cellSize),
          ),
          
      
        segmentPaint,
      );
    }

    // Draw food
    canvas.drawRect(
      Rect.fromPoints(
        Offset(food.dx * cellSize, food.dy * cellSize),
        Offset((food.dx + 1) * cellSize, (food.dy + 1) * cellSize),
      ),
      foodPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class BoundaryPainter extends CustomPainter {
  final int gridSize;
  final double cellSize;

  BoundaryPainter(this.gridSize, this.cellSize);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint boundaryPaint = Paint()
      ..color = Colors.pinkAccent
      ..style = PaintingStyle.stroke;

    // Draw squares for boundaries
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        canvas.drawRect(
            Rect.fromPoints(
              Offset(i * cellSize, j * cellSize),
              Offset((i + 1) * cellSize, (j + 1) * cellSize),
            ),
          boundaryPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}


