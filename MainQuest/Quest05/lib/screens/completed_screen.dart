// Flutter 기본 위젯 패키지 가져오기
import 'package:flutter/material.dart';
// 상태 관리를 위한 Provider 패키지 가져오기
import 'package:provider/provider.dart';
// TodoProvider 클래스 가져오기
import '../providers/todo_provider.dart';
// 할 일 상세 화면 가져오기
import 'todo_detail_screen.dart';

/// 완료된 할 일 목록을 보여주는 화면
class CompletedScreen extends StatelessWidget {
  @override
  // UI 구성 메서드
  Widget build(BuildContext context) {
    // 화면 기본 구조 설정
    return Scaffold(
      // 앱 상단 바
      appBar: AppBar(title: Text('C-T-D')),
      // 화면 본문 - Consumer 위젯으로 TodoProvider의 상태 변화를 감지
      body: Consumer<TodoProvider>(
        // 상태 변화 시 UI를 다시 그리는 빌더 함수
        builder: (context, todoProvider, child) {
          // 완료된 할 일 목록 가져오기
          final completedTodos = todoProvider.completedTodos;

          // 완료된 할 일이 없는 경우 안내 메시지 표시
          if (completedTodos.isEmpty) {
            return Center(child: Text('완료된 할 일이 없습니다'));
          }

          // 완료된 할 일 목록을 ListView로 표시
          return ListView.builder(
            itemCount: completedTodos.length, // 항목 수
            itemBuilder: (context, index) {
              final todo = completedTodos[index]; // 현재 인덱스의 할 일
              // Dismissible 위젯으로 스와이프하여 삭제 기능 구현
              return Dismissible(
                key: Key(todo.id), // 고유 키
                // 스와이프 시 보이는 배경
                background: Container(
                  color: Colors.red, // 빨간색 배경
                  alignment: Alignment.centerRight, // 오른쪽 정렬
                  padding: EdgeInsets.only(right: 20), // 오른쪽 패딩
                  child: Icon(Icons.delete, color: Colors.white), // 삭제 아이콘
                ),
                direction: DismissDirection.endToStart, // 오른쪽에서 왼쪽으로 스와이프
                // 스와이프 완료 시 실행되는 콜백
                onDismissed: (_) {
                  // Todo 삭제
                  todoProvider.deleteTodo(todo.id);
                },
                // 할 일 항목 UI
                child: ListTile(
                  // 할 일 제목 - 취소선과 회색으로 표시
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough, // 취소선
                      color: Colors.grey, // 회색 텍스트
                    ),
                  ),
                  // 완료 아이콘 (녹색 체크)
                  leading: Icon(Icons.check_circle, color: Colors.green),
                  // 탭 시 상세 화면으로 이동
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => TodoDetailScreen(
                              todo: todo,
                            ), // 상세 화면으로 todo 객체 전달
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
