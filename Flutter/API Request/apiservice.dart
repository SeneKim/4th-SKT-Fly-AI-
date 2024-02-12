import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService2 {
  static const String baseUrl = 'https://reqres.in';
  static const path = "api/users?page=2";

  // 단순히 data만 가져오는 것을 확인할 함수
  // debug console을 통해 데이터를 정상적으로 가져오는지 보기 가능
  static Future<List<Preprocess2Json>> getPersonalData() async {
    //추출한 json data를 저장할 list
    List<Preprocess2Json> peopleList = [];

    // 접속할 url 생성
    final url = Uri.parse('$baseUrl/$path');

    // get request, 비동기식 처리
    final response = await http.get(url);

    // 만약 서버 연결이 안된다면?
    if (response.statusCode == 200) {
      // body -> string type
      // 따라서 json type으로 변환
      final Map<String, dynamic> personaldata = jsonDecode(response.body);
      for (var data in personaldata['data']) {
        // 데이터 뽑아내기
        peopleList.add(Preprocess2Json.fromJson(data));
      }

      return peopleList;
    }
    throw Error();
  }
}

// 받아온 데이터를 json으로 정제하는 것이 필요하다!
// 받아온 데이터로 변수 초기화해주기
class Preprocess2Json {
  final int id;
  final String email, firstName, lastName, avatar;

  Preprocess2Json.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        firstName = json['first_name'],
        lastName = json['last_name'],
        avatar = json['avatar'];
}
