import 'package:flutter/material.dart';
import 'package:hello_world/button.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

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
        backgroundColor: const Color(0xFF181818),
        body: Padding(
          // EdgeInsets.all: 상하좌우 모두 10의 margin을 준다
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      const Text(
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
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 120,
                  ),
                  const Text(
                    "Total Balance",
                    style: TextStyle(
                      color: Colors.white60,
                    ),
                  ),
                  const Row(
                    children: [
                      Text(
                        '\$5 194 456',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    children: [
                      Button(
                        text: 'Transfer',
                        bgcolor: Colors.amber,
                        textcolor: Colors.black,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Button(
                        text: "Request",
                        bgcolor: Colors.white24,
                        textcolor: Colors.white60,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Wallets",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          fontFamily: AutofillHints.addressCity,
                        ),
                      ),
                      Text(
                        "View All",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Euro',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "6 428",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "EUR",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 18,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
