import 'package:flutter/material.dart';

class BenefitItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String action;
  final String? livestreaming;

  const BenefitItem({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.action,
    this.livestreaming,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 6, 22, 6),
      margin: const EdgeInsets.only(top: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.network(
                // 네트워크 이미지를 표시
                imageUrl,
                width: 57,
                height: 57,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 15),
              Column(
                // 이미지 옆에 제목(title)과 동작(action)을 세로로 배치
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFFC3C3C6),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    action,
                    style: const TextStyle(
                      color: Color(0xFF4880EE),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (livestreaming != null) // livestreaming 값이 존재할 때만 표시
            Container(
              padding: const EdgeInsets.fromLTRB(7, 4, 7, 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFF323237),
              ),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '방송 중',
                      style: const TextStyle(
                        fontFamily: 'SpoqaHanSansNeo',
                        color: Color(0xFFC3C3C6),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
