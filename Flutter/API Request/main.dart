// to get response from REST API

// api request하는 class 정의한 file import하기
import 'package:flutter/material.dart';
import 'apiservice2.dart';

void main() {
  runApp(APiRequest());
}

/*// 값을 받아올 무언가를 생성.. in stateful widget
  List<Preprocess2Json> person = [];
  bool isLoading = true;

  // 비동기식으로 api의 데이터를 받아온다. - 기본적인 방법
  void waitForPerson() async {
    person = await ApiService2.getPersonalData(); // 데이터를 받아오는 함수를 호출
    isLoading = false;
    setState(() {}); // 스크린 init
  }

  @override
  void initState() {
    super.initState();
    waitForPerson(); 
  } '''
*/

// future builder 사용해보기 - stateless widget에서도 사용가능
// Text에 호출해서 보여주자!
class APiRequest extends StatelessWidget {
  APiRequest({super.key});

  final Future<List<Preprocess2Json>> people = ApiService2.getPersonalData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("User Info"),
          centerTitle: true,
          backgroundColor: Colors.amber,
        ),
        backgroundColor: const Color(0xFF181818),
        body: FutureBuilder(
          future: people,
          builder: (context, snapshot) {
            // snapshot을 사용하면 future가 데이터를 받았는지 오류가 났는지 확인할 수 있다.
            if (snapshot.hasData) {
              // snapshot이 오직 데이터를 받았을 때만 작동된다.
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: makeList(snapshot),
                  )
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<Preprocess2Json>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data!.length,
      // builder 지정 필요
      // future builder와 유사하지만 index 별로만 접근할 수 있다.
      // item을 build할 때 호출하는 함수
      // 모든 아이템을 한 번에 만들고 보여주고자 하는 데이터에만 builder 함수가 실행
      itemBuilder: (context, index) {
        var person = snapshot.data![index];
        return Column(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                    image: NetworkImage(person.avatar),
                  )),
            ),
            Text(
              "First Name: ${person.firstName}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            Text(
              "Last Name: ${person.lastName}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            Text(
              "UserID: ${person.id}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            Text(
              "Email: ${person.email}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        );
      },

      // separatorbuilder를 사용하면 api로 호출받은 데이터 사이에 간격을 추가해줄 수 있다.
      separatorBuilder: (context, index) => const SizedBox(
        height: 20,
      ),
      /* 만약 listview만 활용한다면?
             Listview(            
              children: [
                // ! : data가 항상 존재할 것이라고 확언하는 표기
                for (var person in snapshot.data!)
                  Text(
                    person.firstName,
                    style: const TextStyle(color: Colors.white),
                  )
              ],)*/
    );
  }
}
