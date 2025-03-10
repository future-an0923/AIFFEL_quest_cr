import 'package:flutter/material.dart';
import '../../svg_icons.dart'; // 아이콘 관련 import

class ShoppingHeader extends StatelessWidget {
  const ShoppingHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 18, 18, 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF17171B),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '토스쇼핑',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            children: [
              _buildHeaderText('현장결제'),
              const SizedBox(width: 20),
              _buildIcon(SearchIcon(), width: 10, height: 24),
              const SizedBox(width: 30),
              _buildIcon(PersonIcon(), width: 10, height: 27),
              const SizedBox(width: 30),
              _buildIcon(ShoppingcartIcon(), width: 25, height: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF62626C),
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildIcon(Widget icon, {double width = 24, double height = 24}) {
    return SizedBox(width: width, height: height, child: icon);
  }
}
