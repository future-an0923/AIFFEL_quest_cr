// Flutter의 기본 패키지에서 ChangeNotifier를 가져옵니다.
import 'package:flutter/foundation.dart';
// Todo 모델 클래스를 가져옵니다.
import '../models/todo.dart';

/// Todo 항목들의 상태를 관리하는 Provider 클래스
/// ChangeNotifier를 상속받아 상태 변경 시 리스너들에게 알림을 보냅니다.
class TodoProvider extends ChangeNotifier {
  // Todo 항목들을 저장하는 private 리스트
  final List<Todo> _todos = [];

  /// 모든 Todo 항목을 반환하는 getter
  List<Todo> get todos => _todos;

  /// 완료된 Todo 항목만 필터링하여 반환하는 getter
  List<Todo> get completedTodos =>
      _todos.where((todo) => todo.isCompleted).toList();

  /// 완료되지 않은 Todo 항목만 필터링하여 반환하는 getter
  List<Todo> get activeTodos =>
      _todos.where((todo) => !todo.isCompleted).toList();

  /// 새 Todo 항목을 추가하는 메서드
  void addTodo(Todo todo) {
    _todos.add(todo); // 리스트에 Todo 추가
    notifyListeners(); // 리스너들에게 상태 변경 알림
  }

  /// Todo 항목의 완료 상태를 전환하는 메서드
  void toggleTodo(String id) {
    // ID로 Todo 항목의 인덱스를 찾습니다
    final todoIndex = _todos.indexWhere((todo) => todo.id == id);
    // 해당 ID의 Todo가 존재할 경우에만 상태를 변경
    if (todoIndex >= 0) {
      // 완료 상태를 반전시킵니다(true→false 또는 false→true)
      _todos[todoIndex].isCompleted = !_todos[todoIndex].isCompleted;
      notifyListeners(); // 리스너들에게 상태 변경 알림
    }
  }

  /// Todo 항목의 내용을 업데이트하는 메서드
  void updateTodo(String id, String title, String description) {
    // ID로 Todo 항목의 인덱스를 찾습니다
    final todoIndex = _todos.indexWhere((todo) => todo.id == id);
    // 해당 ID의 Todo가 존재할 경우에만 내용을 업데이트
    if (todoIndex >= 0) {
      _todos[todoIndex].title = title; // 제목 업데이트
      _todos[todoIndex].description = description; // 설명 업데이트
      notifyListeners(); // 리스너들에게 상태 변경 알림
    }
  }

  /// Todo 항목을 삭제하는 메서드
  void deleteTodo(String id) {
    // ID가 일치하는 Todo 항목을 리스트에서 제거
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners(); // 리스너들에게 상태 변경 알림
  }
}
