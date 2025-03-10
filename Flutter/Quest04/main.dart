import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/toss_benefitsscreen.dart';
import 'screens/toss_homescreen.dart';
import 'screens/toss_shoppingscreen.dart';
import 'screens/toss_allscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toss App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SpoqaHanSansNeo',
        scaffoldBackgroundColor: const Color(0xFF101012),
        primarySwatch: Colors.blue,
      ),
      // 라우트 정의
      initialRoute: '/',
      routes: {
        '/': (context) => const TossApp(), // 기본 화면
        '/benefits': (context) => const BenefitsScreen(), // 혜택 화면
        '/toss_shopping': (context) => const TossshoppingScreen(), // 쇼핑 화면
        '/all_menu': (context) => const AllMenuScreen(), // 전체 메뉴 화면
      },
    );
  }
}
