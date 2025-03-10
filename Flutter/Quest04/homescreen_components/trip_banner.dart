import 'package:flutter/material.dart';
import '../../svg_icons.dart';

class TripBanner extends StatelessWidget {
  const TripBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth =
        MediaQuery.of(context).size.width; // 화면 너비에 따라 배너의 크기를 조정
    final isSmallScreen =
        screenWidth < 640; // 작은 화면(width < 640px)에서는 화면 너비에서 30px을 뺀 값을 사용
    final bannerWidth =
        isSmallScreen ? screenWidth - 30 : 360.0; // 큰 화면에서는 고정 너비 360px을 사용

    return Container(
      width: bannerWidth,
      height: 87,
      margin: const EdgeInsets.symmetric(horizontal: 15), // 좌우
      padding: const EdgeInsets.fromLTRB(26, 20, 18, 20), // 좌, 상, 우, 하
      decoration: BoxDecoration(
        color: const Color(0xFF17171B),
        borderRadius: BorderRadius.circular(20), // 모서리 둥글기
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // 좌측에 아이콘과 텍스트, 우측에 화살표 아이콘을 배치
        children: [
          Row(
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: const Center(child: AirplaneIcon(color: Colors.blue)),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    '올여름에 쓸',
                    style: TextStyle(color: Color(0xFF9E9EA3), fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '여행비 모으기',
                    style: TextStyle(
                      color: Color(0xFF4880EE),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            width: 26,
            height: 26,
            child: ArrowIcon(color: const Color(0xFF62626C)),
          ),
        ],
      ),
    );
  }
}
