import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'server_api.dart';

class ScoreBoard extends StatefulWidget {
  @override
  _ScoreBoardState createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  List<int> scores = []; 
  bool isLoading = true; 

  final _focusNode = FocusNode();

  Future<void> fetchScores() async {
    try {
      final fetchedScores = await fetchScoresFromServer();
      setState(() {
        scores = fetchedScores; 
        isLoading = false; 
      });
    } catch (e) {
      print('Failed to fetch scores: $e');
      setState(() {
        isLoading = false; 
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch scores. Please try again.')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    fetchScores(); 
  }

  @override
  void dispose(){
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center( 
        child:
      Stack(alignment: Alignment.center,
      children: [
       KeyboardListener(
        focusNode: _focusNode, 
        onKeyEvent: (KeyEvent event){
          if (event is KeyDownEvent){
            if (event.logicalKey == LogicalKeyboardKey.escape ){
              Navigator.pop(context);
            }
          }
        },
          child: Container(),
       ),
      isLoading
          ? Center(child: CircularProgressIndicator()) 
          : scores.isEmpty
              ? Center(child: Text('No scores available',style: TextStyle(fontFamily: 'SnaredrumZero', fontSize: 50))) // 점수가 없을 경우
              : Center(child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center, 
                crossAxisAlignment: CrossAxisAlignment.center, 
                children: [Text('Score Board', style: TextStyle(fontFamily: 'SnaredrumZero', fontSize: 50),),
                Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(8.0),
                  children: scores.map((score) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Score: $score',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'SnaredrumZero',
                          fontSize: 30,
                        ),
                      ),
                    );
                  }).toList(),))]
              ),)
    ],)));
  }
}
