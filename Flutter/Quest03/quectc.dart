import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => FirstPage(),
        '/second': (context) => SecondPage(),
      },
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

// 167p 정적인 화면 만들기
class _FirstPageState extends State<FirstPage> {
  bool is_cat = true; // bool로 is_cat변수를 만듬 초기값은 true
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.pets), // 좌측 상단에 고양이 아이콘
        title: Center(child: Text('First Page')), // 중앙에 Frist Page라는 텍스트
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 화면 중앙
          children: <Widget>[
            ElevatedButton(
              child: Text('Next'), // Next라는 버튼
              onPressed: () async {
                // 클릭하면
                setState(() {
                  is_cat = false; // false로 초기화
                });
                final result = await Navigator.pushNamed(
                  // 351p
                  context,
                  '/second',
                  arguments: {'is_cat': is_cat},
                );
                if (result == true) {
                  // SecondPage에서 true를 반환했다면
                  setState(() {
                    is_cat = true; // isCat을 다시 true로 설정
                  });
                }
              },
            ),
            SizedBox(height: 20),
            GestureDetector(
              // 212p 사용자 이벤트 처리하기
              onTap: () {
                // 이미지를 누르면
                print('$is_cat'); // 현재 상태를 출력
              },
              child: Image.network(
                'https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNTAyMDlfMjgg%2FMDAxNzM5MTAwNzE0MTY3.7_i1rMlejWmExltMVd1NNoMmbSz8th0Rv6_iprgReUsg.D7vHdjvNaomlwhwpocTtbuorskHkZ6daH-gPrN2Tu7og.JPEG%2Fv6.jpg&type=a340', // 고양이 이미지 (300x300)
                width: 300,
                height: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    Map<String, Object> args =
        ModalRoute.of(context)?.settings.arguments
            as Map<String, Object>; // 350p 데이터 전달, 정보 접근
    bool is_cat = args?['is_cat'] as bool? ?? true;

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.pets), // 좌측 상단에 고양이 아이콘
        title: Center(child: Text('Second Page')), // 중앙에 Second Page라는 텍스트
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 화면 중앙
          children: <Widget>[
            ElevatedButton(
              child: Text('Back'), // Back이라는 버튼
              onPressed: () {
                // 클릭하면
                Navigator.pop(context, true); // true 값을 반환 351p
              },
            ),
            SizedBox(height: 20),
            GestureDetector(
              // 212p 사용자 이벤트 처리하기
              onTap: () {
                print('$is_cat');
              },
              child: Image.network(
                'https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNDAzMTdfMjAx%2FMDAxNzEwNjQ3OTQ2MjAw.IBNewUJUuKBxALyP_U_PqGEsdCciNa1CGTEmys3e_icg.2exGnpsxQotBII6WbkdZgHcED-FqvijXjTlOI7moszQg.JPEG%2Fbl5.jpg&type=a340', // 강아지 이미지 (300x300)
                width: 300,
                height: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// pushNamed()함수로 화면 전환할 때 데이터 전달하였다 책을 많이 참고하였던거 같다. 반환하는 과정과 데이터를 받는법에 대해 아직 부족한거 같다.

// if (result == true) {  // SecondPage에서 true를 반환했다면
//                   setState(() {
//                     is_cat = true; // isCat을 다시 true로 설정
//                   });
