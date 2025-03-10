import 'package:flutter/material.dart';
import '../../svg_icons.dart';

class TossHeader extends StatelessWidget {
  const TossHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 95, height: 35, child: work_to_do()),
          Row(
            children: [
              SizedBox(width: 40, height: 40, child: gyeoljeIcon()),
              const SizedBox(width: 15),
              SizedBox(width: 30, height: 30, child: NotificationIcon()),
              const SizedBox(width: 15),
            ],
          ),
        ],
      ),
    );
  }
}
