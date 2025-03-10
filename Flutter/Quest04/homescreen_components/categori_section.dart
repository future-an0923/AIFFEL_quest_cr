import 'package:flutter/material.dart';

class AccountCategoryTabs extends StatefulWidget {
  const AccountCategoryTabs({Key? key}) : super(key: key);

  @override
  State<AccountCategoryTabs> createState() => _AccountCategoryTabsState();
}

class _AccountCategoryTabsState extends State<AccountCategoryTabs> {
  int _selectedIndex = 3; // '전체' 탭이 기본으로 선택되도록 설정

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF17171B), // 배경색 설정
        borderRadius: BorderRadius.circular(15), // 모서리를 둥글게 처리
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTabButton(0, '대출 0'),
          SizedBox(width: 28),
          _buildDivider(),
          SizedBox(width: 28),
          _buildTabButton(1, '증권 0'),
          SizedBox(width: 28),
          _buildDivider(),
          SizedBox(width: 28),
          _buildTabButton(2, '저축 0'),
          SizedBox(width: 28),
          _buildDivider(),
          SizedBox(width: 28),
          _buildTabButton(3, '전체 2'),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(width: 1, height: 30, color: const Color(0xFF62626C));
  }

  Widget _buildTabButton(int index, String label) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      // GestureDetector를 사용하여 탭 동작을 처리
      onTap: () {
        setState(() {
          // 탭 시 setState를 호출하여 선택된 탭 인덱스를 업데이트
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color:
                  isSelected
                      ? const Color(0xFFC3C3C6)
                      : Colors.transparent, // 선택된 탭에 흰색 밑줄
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
