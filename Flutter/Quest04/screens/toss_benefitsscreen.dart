import 'package:flutter/material.dart';
import 'benefit_item.dart';
import '/svg_icons.dart';
import '../homescreen_components/all_bottom_navigation.dart';

class BenefitsScreen extends StatelessWidget {
  const BenefitsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF17171B),
      body: SafeArea(
        child: Column(
          // 화면을 세로로 나누어 위쪽에는 메인 콘텐츠 아래쪽에는 하단 네비게이션
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [_buildHeader(), _buildBenefitsList()],
                ), // _buildHeader()와 _buildBenefitsList() 두 가지 주요 위젯으로 구성
              ),
            ),
            const BottomNavigation(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      // Container를 사용해 헤더 전체에 패딩과 배경색을 추가
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 18, 18, 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          20,
        ), // borderRadius를 적용하여 모서리를 둥글게 처리
        color: const Color(0xFF17171B),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '혜택',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            children: [
              SizedBox(width: 23, height: 23, child: PointIcon()),

              const SizedBox(width: 8),
              Text(
                '0 원',
                style: TextStyle(
                  color: const Color(0xFFC3C3C6),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              SizedBox(
                width: 20,
                height: 25,
                child: ArrowIcon(color: const Color(0xFF62626C)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitsList() {
    return Container(
      // Container로 전체 리스트를 감싸고 가로 크기를 화면 너비에 맞춰줌
      width: double.infinity,
      child: Column(
        // 세로 방향으로 정렬
        children: [
          BenefitItem(
            // BenefitItem 위젯을 사용하여 혜택 항목을 쉽게 추가하거나 수정
            imageUrl:
                'https://cdn.builder.io/api/v1/image/assets/TEMP/c6c5aa0ffb800b31def9427135db39566fb79f95dc7fc068ee35ba682bfd8270?placeholderIfAbsent=true&apiKey=d77d6873aca74dfd8e8261c40d32b0bf',
            title: '친구와 함께 토스 켜고',
            action: '포인트 받기',
          ),
          BenefitItem(
            imageUrl:
                'https://cdn.builder.io/api/v1/image/assets/TEMP/63a600d6dd9cdbb059e35fdab2e4a59e226c2bec6c9336d266f2250276876de4?placeholderIfAbsent=true&apiKey=d77d6873aca74dfd8e8261c40d32b0bf',
            title: '만보기',
            action: '포인트 받기',
          ),
          BenefitItem(
            imageUrl:
                'https://cdn.builder.io/api/v1/image/assets/TEMP/a43db2e4978c21d9b07c9ddd9421c10c495d7fdf955fb99e236c96fc2572e854?placeholderIfAbsent=true&apiKey=d77d6873aca74dfd8e8261c40d32b0bf',
            title: '오늘의 행운복권',
            action: '포인트 받기',
          ),
          BenefitItem(
            imageUrl:
                'https://cdn.builder.io/api/v1/image/assets/TEMP/74c56276f6843fa01d21e9bcba7425bf2d66fd2056117280154412d1f4bf3b30?placeholderIfAbsent=true&apiKey=d77d6873aca74dfd8e8261c40d32b0bf',
            title: '라이브 쇼핑',
            action: '포인트 받기',
            livestreaming: '방송 중',
          ),
          BenefitItem(
            imageUrl:
                'https://cdn.builder.io/api/v1/image/assets/TEMP/3abaacb0497afca65d71034e542fce868b5e26958b5301ead660643c3cc297b6?placeholderIfAbsent=true&apiKey=d77d6873aca74dfd8e8261c40d32b0bf',
            title: '행운퀴즈',
            action: '추가 혜택 보기',
          ),
          BenefitItem(
            imageUrl:
                'https://cdn.builder.io/api/v1/image/assets/TEMP/81791b83178aa568c3dcd63b03e3f77b759f28d2dba6be1004bbb9418c54f49e?placeholderIfAbsent=true&apiKey=d77d6873aca74dfd8e8261c40d32b0bf',
            title: '이번 주 미션',
            action: '얼마 받을 지 보기',
          ),
        ],
      ),
    );
  }
}
