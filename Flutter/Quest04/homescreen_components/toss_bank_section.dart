import 'package:flutter/material.dart';
import '../../svg_icons.dart';

class TossBankSection extends StatelessWidget {
  const TossBankSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 640;
    final sectionWidth = isSmallScreen ? screenWidth - 30 : 360.0;

    return Container(
      width: sectionWidth,
      height: 66,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 21),
      decoration: BoxDecoration(
        color: const Color(0xFF17171B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '토스뱅크',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            width: 26,
            height: 20,
            child: ArrowIcon(color: const Color(0xFF62626C)),
          ),
        ],
      ),
    );
  }
}
