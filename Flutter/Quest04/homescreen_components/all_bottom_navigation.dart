import 'package:flutter/material.dart';
import '../../svg_icons.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 77,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      color: const Color(0xFF17171B),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavItem(
            icon: HomeIcon(),
            label: '홈',
            isActive: true,
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          NavItem(
            icon: BenefitsIcon(),
            label: '혜택',
            onTap: () {
              Navigator.pushNamed(context, '/benefits');
            },
          ),
          NavItem(
            icon: ShoppingbagIcon(),
            label: '토스쇼핑',
            onTap: () {
              Navigator.pushNamed(context, '/toss_shopping');
            },
          ),
          NavItem(icon: StocksIcon(), label: '주식'),
          NavItem(
            icon: MenuIcon(),
            label: '전체',
            onTap: () {
              Navigator.pushNamed(context, '/all_menu');
            },
          ),
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final Widget icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  const NavItem({
    Key? key,
    required this.icon,
    required this.label,
    this.isActive = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 20, height: 20, child: icon),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : const Color(0xFF9E9EA3),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
