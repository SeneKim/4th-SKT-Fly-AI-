import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override //부모 class에 있는 메소드 오버라이드
  Widget build(BuildContext context) {
    // 어떤 family style을 사용할지 알려준다.
    return MaterialApp(
        // Delete Appbar
        home: Scaffold(
            // 위 아래로 놓고 싶다면 -> Column
            // 양 옆으로 놓고 싶다면 -> Row
            // Colors.{Color what you want}.{채도}
            // Custom color = Color(0xFF(추출한 색 코드))
            backgroundColor: Color(0xFF181818),
            body: Padding(
              // EdgeInsets.all: 상하좌우 모두 10의 margin을 준다
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Hey, Selena',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text('Welcome back',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white
                                    .withOpacity(0.7), //withOpacity: 투명도
                              )),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )));
  }
}
