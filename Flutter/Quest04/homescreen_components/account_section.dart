import 'package:flutter/material.dart';
import '../../svg_icons.dart';

class AssetsSection extends StatelessWidget {
  const AssetsSection({Key? key}) : super(key: key);

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
            bankName: '국민은행 통장',
            iconWidget: KBIcon(),
            balance: '10,000원',
          ),
          const AccountItem(
            bankName: '토스뱅크 통장',
            iconWidget: TossBankIcon(),
            balance: '100,000원',
          ),
        ],
      ),
    );
  }
}

class AccountItem extends StatelessWidget {
  final String bankName;
  final String balance;
  final Widget? iconWidget;
  final bool useImageIcon;

  const AccountItem({
    Key? key,
    required this.bankName,
    required this.balance,
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
              Container(
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
                    balance,
                    style: TextStyle(
                      color: Color(0xFFE4E4E5),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    bankName,
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
            padding: const EdgeInsets.fromLTRB(13, 8, 13, 7),
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C34),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              '송금',
              style: TextStyle(color: Color(0xFFE4E4E5), fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
