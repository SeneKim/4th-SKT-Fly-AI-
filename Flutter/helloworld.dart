import 'package:flutter/material.dart';

//doesn't return anything because it's void type
void main() {
  runApp(App());
}

// root widget - 2개의 옵션 중 하나를 return 해야한다,
// material - google design sys
// cupertino - apple design sys

class App extends StatelessWidget {
  // 3개의 flutter widget 중 하나를 상속 받아야함
  // 이를 상속 받기 위해서는 build를 구현해야 한다.
  // flutter가 build에서 무엇을 return하는지 화면에서 보여준다.
  // build = widget의 ui를 만드는 것

  // build 정의
  @override //부모 class에 있는 메소드 오버라이드
  Widget build(BuildContext context) {
    // 어떤 family style을 사용할지 알려준다.
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Hello Flutter'),
      ),
      body: Center(
        child: Text('Hello World!'),
      ),
    ));
  } //cause everything is Widget, must be return Widget

  //화면은 scaffold를 가져야한다.
  // scaffold는 화면의 구조를 제공
  // class 끝날 때마다 ,를 찍으면 무엇인지 주석을 달아준다.
}
