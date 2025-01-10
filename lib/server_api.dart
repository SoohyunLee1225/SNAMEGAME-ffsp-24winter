// import 'dart:io';
// import 'dart:convert';


// const String serverPath = 'http://localhost:4040/scores';

// Future<void> sendScoreToServer(int score) async {
//   var serverIP = InternetAddress.loopbackIPv4.host;
//   var serverPort = 4040;
 
//   var httpClient = HttpClient();
//   var httpResponseContent;

//   HttpClientRequest httpRequest;
//   HttpClientResponse httpResponse;

//   Map jsonContent = {'serverIP':serverIP, 'score':score};
//   var content = jsonEncode(jsonContent);
  
//   httpRequest = await httpClient.post(serverIP, serverPort, serverPath)
//   ..headers.contentType = ContentType.json
//   ..headers.contentLength = content.length
//   ..write(content);

//   httpResponse = await httpRequest.close();
  
// }

// Future<List<dynamic>> fecthScoreFromServer() async{
//   var serverIP = InternetAddress.loopbackIPv4.host;
//   var serverPort = 4040;
 
//   var httpClient = HttpClient();
//   dynamic httpResponseContent;
//   HttpClientRequest httpRequest;
//   HttpClientResponse httpResponse;
  
//   httpRequest = await httpClient.get(serverIP, serverPort, serverPath);
//   httpResponse = await httpRequest.close();
//   httpResponseContent = await utf8.decoder.bind(httpResponse).join();

//   return httpResponseContent;


// }

import 'dart:convert';
import 'dart:io';

const String serverUrl = 'http://localhost:8080/scores';

// 서버로 점수 전송
Future<void> sendScoreToServer(int score) async {
  final request = await HttpClient().postUrl(Uri.parse(serverUrl));
  request.headers.contentType = ContentType.json;
  request.write(jsonEncode({'score': score}));

  final response = await request.close();
  if (response.statusCode == HttpStatus.ok) {
    print('Score sent successfully');
  } else {
    print('Failed to send score: ${response.statusCode}');
  }
}

// 서버에서 모든 점수 조회
Future<List<int>> fetchScoresFromServer() async {
  final request = await HttpClient().getUrl(Uri.parse(serverUrl));
  final response = await request.close();

  if (response.statusCode == HttpStatus.ok) {
    final responseBody = await response.transform(utf8.decoder).join();
    final data = jsonDecode(responseBody) as Map<String, dynamic>;
    return List<int>.from(data['scores']);
  } else {
    print('Failed to fetch scores: ${response.statusCode}');
    return [];
  }
}
