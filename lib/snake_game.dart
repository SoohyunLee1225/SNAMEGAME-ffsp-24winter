import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fssp_snakegame/gameover_score.dart';



// class _Direction{
//   Offset up = Offset(0, 1);
//   Offset down = Offset(0, -1);
//   Offset left = Offset(-1, 0);
//   Offset right = Offset(-1, 0);

//   @override
//   bool]]\\ operator ==(Object other) {
//     // TODO: implement ==
//     return super == other;
//   }

// }



class GamePlay extends StatelessWidget{
  const GamePlay({super.key});
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints){
            double imageWidth = constraints.maxWidth * 0.9;
            double imageHeight = constraints.maxHeight * 0.9;
          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: imageWidth,
                height: imageHeight,
                decoration:BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.cover,

                  )
                )),
                Positioned(
                  width: imageWidth*0.8,
                  height: imageHeight*0.8,
                  child: SnakeGame(),)
            ]

        );
        }
      )
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
  static int screenSize=300;
  static  int gridCount= screenSize ~/ gridSize;
  static const double initialSpeed = 100.0;
  double cellSize = 20.0;
  
  late double snakeSpeed;

  List<Offset> snake = [Offset(5, 5), Offset(5, 4), Offset(5, 3), Offset(5, 2), Offset(5, 1)];
  Offset food = Offset(10, 10);
  Direction direction = Direction.up;
  Direction keyboardDirection = Direction.up;
  Timer? timer;
  int score = 0;
  bool isGameRunning = false;

  FocusNode _focusNode = FocusNode();
  Offset inputoffset = Offset(0, 0);

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  void startGame(){
    if (!isGameRunning){
      setState(() {
        snakeSpeed = initialSpeed;
        snake = [Offset(10, 14), Offset(10, 15), Offset(10, 16), Offset(10, 17), Offset(10, 18)];
        direction = Direction.down;
        isGameRunning = true;
        score=0;
        generateFood();
        timer = Timer.periodic(Duration(microseconds: snakeSpeed.toInt()), 
        (Timer t){
          moveSnake();
          checkCollision();
        });
      });
    }
  }

  void generateFood(){ //음식 위치를 랜덤으로 생성하고, 만약 음식 위치가 뱀과 겹친다면 다시 생성
    final Random rand = Random();
    Offset newFood;
    do{
      newFood = Offset(
        rand.nextInt(gridCount).toDouble(),
        rand.nextInt(gridCount).toDouble()
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
        snake.first.dx>=gridCount ||
        snake.first.dy<0 ||
        snake.first.dy>=gridCount ||
        snake.sublist(5).contains(snake.first)){
          stopGame();
          // gameOver();
        }
  }

  void stopGame(){
    setState(() {
      isGameRunning = false;
      timer?.cancel();
    });
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
    cellSize = screenSize / gridSize;
    
    return LayoutBuilder(
      builder: (context, constraints){
        double gameWidth = constraints.maxWidth;
        double gameHeight = constraints.maxHeight;

        cellSize= gameWidth/gridSize;
      // constraints: BoxConstraints(maxWidth: screenSize.toDouble()),
      // child: SizedBox(
      //   // width: screenSize.toDouble()+100.0,
      //   // height: screenSize.toDouble()+100.0,
        return Stack(
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
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return KeyboardListener(focusNode: _focusNode, 
                    onKeyEvent: (KeyEvent event){
                      switch(event.physicalKey){
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
                        case PhysicalKeyboardKey.keyX:
                          startGame();
                          break;
                      }
                    },
                    child: Stack(
                        children: [
                          CustomPaint(
                            painter: BoundaryPainter(gridSize, cellSize),
                            size:
                                Size(constraints.maxWidth, constraints.maxWidth),
                          ),
                          CustomPaint(
                            painter:
                                SnakePainter(snake, food, gridSize, cellSize),
                            size:
                                Size(constraints.maxWidth, constraints.maxWidth),
                          ),
                        ],                    
                    ),            
                  );
                  },
              ),
              )  
            )
          ),
          Positioned(
            left: - 20,
            top: 0,
            child: Text('$score',
                          style: TextStyle(fontFamily: 'SnaredrumTwo', fontSize: 50),
                          ),
            )
          ],
       // )
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
    final Paint snakePaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.green, Colors.lightGreen],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromPoints(Offset.zero, Offset(cellSize, cellSize)));

    final Paint foodPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.red, Colors.orange],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromPoints(Offset.zero, Offset(cellSize, cellSize)));

    // Draw snake
    for (Offset position in snake) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromPoints(
            Offset(position.dx * cellSize, position.dy * cellSize),
            Offset((position.dx + 1) * cellSize, (position.dy + 1) * cellSize),
          ),
          Radius.circular(cellSize / 2),
        ),
        snakePaint,
      );
    }

    // Draw food
    canvas.drawRect(
      // RRect.fromRectAndRadius(
      //   Rect.fromPoints(
      //     Offset(food.dx * cellSize, food.dy * cellSize),
      //     Offset((food.dx + 1) * cellSize, (food.dy + 1) * cellSize),
      //   ),
      //   Radius.circular(cellSize / cellSize),
      // ),
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

    // Draw rounded squares for boundaries
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