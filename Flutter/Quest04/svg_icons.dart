import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// This file would normally use flutter_svg to render SVG icons
// For this implementation, we'll create custom painters or use simple widgets

class work_to_do extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min, // Row의 크기를 자식 내용에 맞게 조정
          children: [
            const Text(
              '할 일',
              style: TextStyle(
                color: Color(0xFF62626B),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 5), // 텍스트와 아이콘 간의 간격
            const SizedBox(
              width: 16,
              height: 16,
              child: ArrowIcon(color: Color(0xFF62626C)), // 커스텀 ArrowIcon
            ),
          ],
        ),
      ),
    );
  }
}

class AirplaneIcon extends StatelessWidget {
  final Color color;

  const AirplaneIcon({Key? key, this.color = Colors.blue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.flight, color: color, size: 24);
  }
}

class gyeoljeIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('assets/images/gyeolje.svg', width: 40, height: 40);
  }
}

class NotificationIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.notifications, color: Color(0xFF62626C), size: 30);
  }
}

class ArrowIcon extends StatelessWidget {
  final Color color;

  const ArrowIcon({Key? key, this.color = const Color(0xFF62626C)})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.chevron_right, color: color, size: 25);
  }
}

class KBIcon extends StatelessWidget {
  const KBIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        child: SvgPicture.asset('assets/images/KB.svg', width: 40, height: 40),
      ),
    );
  }
}

class TossBankIcon extends StatelessWidget {
  const TossBankIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SvgPicture.asset('assets/images/toss.svg', width: 40, height: 40),
    );
  }
}

class PointIcon extends StatelessWidget {
  const PointIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SvgPicture.asset('assets/images/point.svg', width: 40, height: 40),
    );
  }
}

class HomeIcon extends StatelessWidget {
  const HomeIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.home_filled, color: Colors.white, size: 20);
  }
}

class BenefitsIcon extends StatelessWidget {
  const BenefitsIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.card_giftcard, color: Color(0xFF62626C), size: 20);
  }
}

class ShoppingbagIcon extends StatelessWidget {
  const ShoppingbagIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FaIcon(
      FontAwesomeIcons.bagShopping,
      color: Color(0xFF62626C),
      size: 20,
    );
  }
}

class ShoppingcartIcon extends StatelessWidget {
  const ShoppingcartIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FaIcon(
      FontAwesomeIcons.cartShopping,
      color: Color(0xFF62626C),
      size: 20,
    );
  }
}

class PersonIcon extends StatelessWidget {
  const PersonIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.person, color: Color(0xFF62626C), size: 25);
  }
}

class SearchIcon extends StatelessWidget {
  const SearchIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.search, color: Color(0xFF62626C), size: 24);
  }
}

class TossPayIcon extends StatelessWidget {
  const TossPayIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 56, 56, 97),
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Text(
          '₩',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class StocksIcon extends StatelessWidget {
  const StocksIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.show_chart, color: Color(0xFF62626C), size: 20);
  }
}

class MenuIcon extends StatelessWidget {
  const MenuIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.menu, color: Color(0xFF62626C), size: 20);
  }
}

// Custom Painters for status bar icons
class SignalIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

    // Draw signal bars
    canvas.drawRect(Rect.fromLTWH(0, size.height - 5, 3, 5), paint);
    canvas.drawRect(Rect.fromLTWH(4, size.height - 8, 3, 8), paint);
    canvas.drawRect(Rect.fromLTWH(8, size.height - 11, 3, 11), paint);
    canvas.drawRect(Rect.fromLTWH(12, size.height - 14, 3, 14), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class WifiIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;

    // Draw WiFi arcs
    final center = Offset(size.width / 2, size.height);
    canvas.drawArc(
      Rect.fromCenter(center: center, width: 10, height: 10),
      3.14,
      3.14,
      false,
      paint,
    );
    canvas.drawArc(
      Rect.fromCenter(center: center, width: 16, height: 16),
      3.14,
      3.14,
      false,
      paint,
    );
    canvas.drawArc(
      Rect.fromCenter(center: center, width: 22, height: 22),
      3.14,
      3.14,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BatteryIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;

    // Draw battery outline
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width - 3, size.height),
        const Radius.circular(3),
      ),
      paint,
    );

    // Draw battery level
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(2, 2, size.width - 7, size.height - 4),
        const Radius.circular(1.5),
      ),
      paint,
    );

    // Draw battery tip
    canvas.drawRect(
      Rect.fromLTWH(size.width - 3, size.height / 3, 3, size.height / 3),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
