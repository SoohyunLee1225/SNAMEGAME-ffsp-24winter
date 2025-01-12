import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'server_api.dart';

class ScoreBoard extends StatefulWidget {
  @override
  _ScoreBoardState createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  List<int> scores = []; // 서버에서 받아온 점수를 저장
  bool isLoading = true; // 로딩 상태

  final _focusNode = FocusNode();

  // 점수를 서버에서 가져오는 함수
  Future<void> fetchScores() async {
    try {
      final fetchedScores = await fetchScoresFromServer();
      setState(() {
        scores = fetchedScores; // 점수 업데이트
        isLoading = false; // 로딩 완료
      });
    } catch (e) {
      print('Failed to fetch scores: $e');
      setState(() {
        isLoading = false; // 로딩 완료 (오류 상태)
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
    fetchScores(); // 페이지 로드 시 점수 가져오기
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
          ? Center(child: CircularProgressIndicator()) // 로딩 중
          : scores.isEmpty
              ? Center(child: Text('No scores available',style: TextStyle(fontFamily: 'SnaredrumZero', fontSize: 50))) // 점수가 없을 경우
              : Center(child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center, // 세로 중앙 정렬
                crossAxisAlignment: CrossAxisAlignment.center, // 가로 중앙 정렬
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
