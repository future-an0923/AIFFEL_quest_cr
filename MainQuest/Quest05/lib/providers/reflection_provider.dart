import 'package:flutter/foundation.dart';
import '../models/reflection.dart';

class ReflectionProvider extends ChangeNotifier {
  // 회고 목록을 저장하는 private 리스트
  final List<Reflection> _reflections = [];

  // 회고 목록에 접근하는 getter
  List<Reflection> get reflections => _reflections;

  // 특정 날짜의 회고를 가져오는 메서드
  Reflection? getReflectionByDate(DateTime date) {
    try {
      // 해당 날짜의 회고를 찾음 (년, 월, 일이 일치하는 항목)
      return _reflections.firstWhere(
        (reflection) =>
            reflection.date.year == date.year &&
            reflection.date.month == date.month &&
            reflection.date.day == date.day,
      );
    } catch (e) {
      // 해당 날짜의 회고가 없으면 null 반환
      return null;
    }
  }

  // 회고 추가 메서드
  void addReflection(Reflection reflection) {
    // 같은 날짜의 회고가 이미 있으면 제거 (하루에 하나의 회고만 허용)
    _reflections.removeWhere(
      (r) =>
          r.date.year == reflection.date.year &&
          r.date.month == reflection.date.month &&
          r.date.day == reflection.date.day,
    );

    // 새 회고 추가
    _reflections.add(reflection);
    // 리스너들에게 상태 변경 알림
    notifyListeners();
  }

  // 회고 삭제 메서드
  void deleteReflection(String id) {
    _reflections.removeWhere((reflection) => reflection.id == id);
    notifyListeners();
  }

  // AI 분석 결과 업데이트
  void updateReflectionWithAIAnalysis(
    String id,
    Map<String, dynamic> analysis,
  ) {
    final index = _reflections.indexWhere((r) => r.id == id);
    if (index != -1) {
      final reflection = _reflections[index];
      _reflections[index] = Reflection(
        id: reflection.id,
        date: reflection.date,
        answers: reflection.answers,
        mood: reflection.mood,
        aiAnalysis: analysis,
      );
      notifyListeners();
    }
  }
}
