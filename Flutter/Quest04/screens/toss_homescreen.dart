import 'package:flutter/material.dart';
import '../homescreen_components/toss_header.dart';
import '../homescreen_components/trip_banner.dart';
import '../homescreen_components/toss_bank_section.dart';
import '../homescreen_components/account_section.dart';
import '../homescreen_components/all_bottom_navigation.dart';
import '../homescreen_components/categori_section.dart';
import '../homescreen_components/consumption_section.dart';

class TossApp extends StatelessWidget {
  const TossApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // MediaQuery를 사용하여 화면 크기 정보
    final isSmallScreen =
        screenSize.width <
        640; // isSmallScreen 변수는 화면 너비가 640px 미만인 경우를 작은 화면으로 간주

    final appWidth =
        isSmallScreen
            ? screenSize.width
            : 390.0; // 작은 화면에서는 전체 화면 크기를 사용하고, 큰 화면에서는 고정된 크기(390x844)를 적용
    final appHeight = isSmallScreen ? screenSize.height : 844.0;

    return Scaffold(
      backgroundColor: const Color(0xFF101012),
      body: SafeArea(
        // 기기의 노치, 상태 바, 소프트 키보드 등을 고려하여 안전한 영역에 콘텐츠를 배치
        child: Container(
          // 앱의 크기를 반응형으로 조정(appWidth, appHeight)하며, 배경색을 다시 한 번 지정
          width: appWidth,
          height: appHeight,
          color: const Color(0xFF101012),
          child: Stack(
            children: [
              Column(
                // Column (메인 콘텐츠)
                children: [
                  const TossHeader(), // 할 일, 결제, 알림 아이콘 부분
                  Expanded(
                    // 여러 섹션이 포함
                    child: SingleChildScrollView(
                      // 메인 콘텐츠 영역 스크롤 가능
                      child: Column(
                        children: const [
                          SizedBox(height: 10),
                          TripBanner(), // 여행비 모으기 부분
                          SizedBox(height: 12),
                          TossBankSection(), // 토스뱅크 부분
                          SizedBox(height: 12),
                          AssetsSection(), // 계좌 및 송금 부분
                          AccountCategoryTabs(), // 대출, 증권, 저축, 전체 부분
                          SizedBox(height: 12),
                          ConsumptionSection(), // 소비 부분
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                // Positioned (하단 네비게이션)
                // bottom, left, right 값을 모두 0으로 설정하여 화면 너비 전체를 차지
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: const [BottomNavigation(), SizedBox(height: 3)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
