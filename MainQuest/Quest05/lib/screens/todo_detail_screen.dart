// Flutter 기본 위젯 패키지 가져오기
import 'package:flutter/material.dart';
// 상태 관리를 위한 Provider 패키지 가져오기
import 'package:provider/provider.dart';
// Todo 모델 클래스 가져오기
import '../models/todo.dart';
// TodoProvider 클래스 가져오기
import '../providers/todo_provider.dart';
// 날짜 형식 지정을 위한 intl 패키지 가져오기
import 'package:intl/intl.dart';

/// 할 일의 상세 정보를 보여주고 편집할 수 있는 화면
class TodoDetailScreen extends StatefulWidget {
  // 표시할 Todo 객체 (필수 매개변수)
  final Todo todo;

  // 생성자: Todo 객체를 필수로 받음
  TodoDetailScreen({required this.todo});

  @override
  // State 객체 생성 메서드
  _TodoDetailScreenState createState() => _TodoDetailScreenState();
}

/// TodoDetailScreen의 상태를 관리하는 State 클래스
class _TodoDetailScreenState extends State<TodoDetailScreen> {
  // 제목 입력을 위한 컨트롤러 (late: 나중에 초기화)
  late TextEditingController _titleController;
  // 설명 입력을 위한 컨트롤러
  late TextEditingController _descriptionController;
  // 완료 상태를 저장하는 변수
  late bool _isCompleted;
  // 폼 유효성 검사를 위한 키
  final _formKey = GlobalKey<FormState>();

  @override
  // 위젯이 생성될 때 호출되는 초기화 메서드
  void initState() {
    super.initState();
    // 컨트롤러에 현재 Todo의 값으로 초기화
    _titleController = TextEditingController(text: widget.todo.title);
    _descriptionController = TextEditingController(
      text: widget.todo.description,
    );
    // 현재 완료 상태 저장
    _isCompleted = widget.todo.isCompleted;
  }

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
    // 날짜 형식 지정 (한국어 형식)
    final dateFormat = DateFormat('yyyy년 MM월 dd일 HH:mm');

    // 화면 기본 구조 설정
    return Scaffold(
      // 앱 상단 바
      appBar: AppBar(
        title: Text('Detail'),
        // 상단 바 오른쪽 액션 버튼
        actions: [
          // 삭제 버튼
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Provider를 통해 Todo 삭제 기능 호출
              Provider.of<TodoProvider>(
                context,
                listen: false, // 상태 변화 감지 비활성화
              ).deleteTodo(widget.todo.id);
              // 이전 화면으로 돌아가기
              Navigator.pop(context);
            },
          ),
        ],
      ),
      // 화면 본문
      body: Padding(
        padding: const EdgeInsets.all(16.0), // 전체 패딩
        // 폼 위젯 - 입력 유효성 검사를 위해 사용
        child: Form(
          key: _formKey,
          // 세로 방향으로 위젯 배치
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
            children: [
              // 생성 시간 표시
              Text(
                '생성 시간: ${dateFormat.format(widget.todo.createdAt)}',
                style: TextStyle(color: Colors.grey[600]), // 회색 텍스트
              ),
              SizedBox(height: 16), // 수직 간격
              // 완료 상태 체크박스
              Row(
                children: [
                  Checkbox(
                    value: _isCompleted, // 현재 완료 상태
                    onChanged: (value) {
                      // 상태 변경 시 UI 업데이트
                      setState(() {
                        _isCompleted = value!; // null 체크 후 값 할당
                      });
                    },
                  ),
                  Text('완료됨'), // 체크박스 레이블
                ],
              ),
              SizedBox(height: 16), // 수직 간격
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
                  labelText: '설명', // 레이블
                  border: OutlineInputBorder(), // 테두리 스타일
                ),
                maxLines: 5, // 여러 줄 입력 가능
              ),
              SizedBox(height: 24), // 수직 간격
              // 저장 버튼 - 화면 너비 전체 사용
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  // 버튼 클릭 시 실행되는 콜백
                  onPressed: () {
                    // 폼 유효성 검사 통과 시에만 실행
                    if (_formKey.currentState!.validate()) {
                      // Provider를 통해 Todo 내용 업데이트
                      Provider.of<TodoProvider>(
                        context,
                        listen: false, // 상태 변화 감지 비활성화
                      ).updateTodo(
                        widget.todo.id,
                        _titleController.text,
                        _descriptionController.text,
                      );

                      // 완료 상태가 변경된 경우 상태 업데이트
                      if (_isCompleted != widget.todo.isCompleted) {
                        Provider.of<TodoProvider>(
                          context,
                          listen: false, // 상태 변화 감지 비활성화
                        ).toggleTodo(widget.todo.id);
                      }

                      // 이전 화면으로 돌아가기
                      Navigator.pop(context);
                    }
                  },
                  // 버튼 내부 UI
                  child: Padding(
                    padding: const EdgeInsets.all(12.0), // 버튼 내부 패딩
                    child: Text('저장하기'), // 버튼 텍스트
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
