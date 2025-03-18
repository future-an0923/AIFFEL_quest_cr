import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import 'add_todo_screen.dart';
import 'todo_detail_screen.dart';
import 'completed_screen.dart';
import 'reflection_screen.dart';
import 'reflection_history_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('T-D-L'),
        actions: [
          // 완료된 할 일 화면으로 이동하는 버튼
          IconButton(
            icon: Icon(Icons.done_all),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CompletedScreen()),
              );
            },
          ),
          // 회고 기록 화면으로 이동하는 버튼
          IconButton(
            icon: Icon(Icons.book),
            onPressed: () {
              // 회고 기록 화면으로 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReflectionHistoryScreen(),
                ),
              );
            },
          ),
        ],
      ),
      // 할 일 목록 표시
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          final activeTodos = todoProvider.activeTodos;

          if (activeTodos.isEmpty) {
            return Center(
              child: Text(
                '               새로운 할 일을 +를 눌러 추가하세요.\n 하루를 정리해보고 싶다면 연필을 눌러 추가하세요.',
              ),
            );
          }

          return ListView.builder(
            itemCount: activeTodos.length,
            itemBuilder: (context, index) {
              final todo = activeTodos[index];
              return Dismissible(
                key: Key(todo.id),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (_) {
                  todoProvider.deleteTodo(todo.id);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('${todo.title} 삭제됨')));
                },
                child: ListTile(
                  title: Text(todo.title),
                  leading: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (_) => todoProvider.toggleTodo(todo.id),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TodoDetailScreen(todo: todo),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      // 여러 버튼을 위한 FloatingActionButtons 추가
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // 회고 작성 버튼
          FloatingActionButton(
            heroTag: 'reflection', // 고유 태그 (충돌 방지)
            onPressed: () {
              // 회고 작성 화면으로 이동
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReflectionScreen()),
              );
            },
            child: Icon(Icons.edit), // 편집 아이콘
            backgroundColor: Colors.green, // 녹색 배경
          ),
          SizedBox(height: 10), // 버튼 간 간격
          // 할 일 추가 버튼 (기존 버튼)
          FloatingActionButton(
            heroTag: 'todo', // 고유 태그 (충돌 방지)
            onPressed: () {
              // 할 일 추가 화면으로 이동
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTodoScreen()),
              );
            },
            child: Icon(Icons.add), // 추가 아이콘
          ),
        ],
      ),
    );
  }
}
