import 'package:flutter/material.dart';
import '../../svg_icons.dart';

class ConsumptionSection extends StatelessWidget {
  const ConsumptionSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 640;
    final sectionWidth = isSmallScreen ? screenWidth - 30 : 360.0;

    return Container(
      width: sectionWidth,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF17171B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const AccountItem(
            text: '2월에 쓴 돈',
            iconWidget: TossPayIcon(),
            consumption: '50,000원',
          ),
        ],
      ),
    );
  }
}

class AccountItem extends StatelessWidget {
  final String text;
  final String consumption;
  final Widget? iconWidget;
  final bool useImageIcon;

  const AccountItem({
    Key? key,
    required this.text,
    required this.consumption,
    this.iconWidget,
    this.useImageIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 38,
                height: 38,
                child:
                    useImageIcon
                        ? const Center(
                          child: Text("🏦", style: TextStyle(fontSize: 24)),
                        ) // Placeholder for image
                        : iconWidget,
              ),

              const SizedBox(width: 10),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    consumption,
                    style: TextStyle(
                      color: Color(0xFFE4E4E5),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    text,
                    style: const TextStyle(
                      color: Color(0xFFC3C3C6),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),

          Container(
            padding: const EdgeInsets.fromLTRB(13, 8, 13, 7), // 내역 버튼 영역
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C34),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              '내역',
              style: TextStyle(color: Color(0xFFE4E4E5), fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
