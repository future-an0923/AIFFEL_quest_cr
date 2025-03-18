// UUID 패키지를 가져와 고유 식별자를 생성합니다.
import 'package:uuid/uuid.dart';

/// Todo 항목을 나타내는 데이터 모델 클래스입니다.
class Todo {
  // 고유 식별자 - 변경 불가능(final)
  final String id;
  // 할 일 제목
  String title;
  // 할 일 상세 설명
  String description;
  // 완료 여부 상태
  bool isCompleted;
  // 생성 시간
  DateTime createdAt;

  /// Todo 객체 생성자
  Todo({
    required this.title, // 필수 매개변수
    this.description = '', // 선택적 매개변수, 기본값 빈 문자열
    this.isCompleted = false, // 선택적 매개변수, 기본값 false
  })
    // 초기화 리스트: 생성자 본문 실행 전에 필드 초기화
    : id = const Uuid().v4(), // UUID v4 형식의 랜덤 ID 생성
       createdAt = DateTime.now(); // 현재 시간을 생성 시간으로 기록
}
