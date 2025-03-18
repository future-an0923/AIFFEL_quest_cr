// Flutter 기본 위젯 패키지 가져오기
import 'package:flutter/material.dart';
// 상태 관리를 위한 Provider 패키지 가져오기
import 'package:provider/provider.dart';
// Todo 모델 클래스 가져오기
import '../models/todo.dart';
// TodoProvider 클래스 가져오기
import '../providers/todo_provider.dart';

/// 새로운 할 일을 추가하는 화면
class AddTodoScreen extends StatefulWidget {
  @override
  // State 객체 생성 메서드
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

/// AddTodoScreen의 상태를 관리하는 State 클래스
class _AddTodoScreenState extends State<AddTodoScreen> {
  // 제목 입력을 위한 컨트롤러
  final _titleController = TextEditingController();
  // 설명 입력을 위한 컨트롤러
  final _descriptionController = TextEditingController();
  // 폼 유효성 검사를 위한 키
  final _formKey = GlobalKey<FormState>();

  @override
  // 위젯이 제거될 때 호출되는 정리 메서드
  void dispose() {
    // 메모리 누수 방지를 위해 컨트롤러 해제
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  // UI 구성 메서드
  Widget build(BuildContext context) {
    // 화면 기본 구조 설정
    return Scaffold(
      // 앱 상단 바
      appBar: AppBar(title: Text('A-T-D')),
      // 화면 본문
      body: Padding(
        padding: const EdgeInsets.all(16.0), // 전체 패딩
        // 폼 위젯 - 입력 유효성 검사를 위해 사용
        child: Form(
          key: _formKey,
          // 세로 방향으로 위젯 배치 (화면 너비 전체 사용)
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // 가로 방향으로 늘리기
            children: [
              // 제목 입력 필드
              TextFormField(
                controller: _titleController, // 컨트롤러 연결
                decoration: InputDecoration(
                  labelText: '제목', // 레이블
                  border: OutlineInputBorder(), // 테두리 스타일
                ),
                // 유효성 검사 - 빈 값 체크
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '제목을 입력해주세요'; // 오류 메시지
                  }
                  return null; // 유효한 경우 null 반환
                },
              ),
              SizedBox(height: 16), // 수직 간격
              // 설명 입력 필드
              TextFormField(
                controller: _descriptionController, // 컨트롤러 연결
                decoration: InputDecoration(
                  labelText: '설명 (선택사항)', // 레이블
                  border: OutlineInputBorder(), // 테두리 스타일
                ),
                maxLines: 5, // 여러 줄 입력 가능
              ),
              SizedBox(height: 24), // 수직 간격
              // 추가 버튼
              ElevatedButton(
                // 버튼 클릭 시 실행되는 콜백
                onPressed: () {
                  // 폼 유효성 검사 통과 시에만 실행
                  if (_formKey.currentState!.validate()) {
                    // 새 Todo 객체 생성
                    final newTodo = Todo(
                      title: _titleController.text,
                      description: _descriptionController.text,
                    );

                    // Provider를 통해 Todo 추가
                    Provider.of<TodoProvider>(
                      context,
                      listen: false, // 상태 변화 감지 비활성화
                    ).addTodo(newTodo);

                    // 이전 화면으로 돌아가기
                    Navigator.pop(context);
                  }
                },
                // 버튼 내부 UI
                child: Padding(
                  padding: const EdgeInsets.all(12.0), // 버튼 내부 패딩
                  child: Text('추가하기'), // 버튼 텍스트
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
