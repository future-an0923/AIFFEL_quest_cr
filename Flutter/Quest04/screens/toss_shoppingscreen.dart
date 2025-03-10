import 'package:flutter/material.dart';
import '../shoppingscreen_component/shopping_header.dart';
import '../shoppingscreen_component/shopping_mainbanner.dart';
import '../shoppingscreen_component/shopping_dailyspecial.dart';
import '../shoppingscreen_component/shopping_Todaysproduct.dart';
import '../homescreen_components/all_bottom_navigation.dart';

class TossshoppingScreen extends StatelessWidget {
  const TossshoppingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF17171B),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    ShoppingHeader(),
                    ShoppingMainbanner(),
                    SizedBox(height: 10),
                    ShoppingDailyspecial(),
                    SizedBox(height: 20),
                    ShoppingTodaysproduct(),
                  ],
                ),
              ),
            ),
            const BottomNavigation(),
          ],
        ),
      ),
    );
  }
}
