class Reflection {
  final String id;
  final DateTime date;
  final Map<String, String> answers;
  final String mood;
  final Map<String, dynamic>? aiAnalysis; // AI 분석 결과 추가

  Reflection({
    required this.id,
    required this.date,
    required this.answers,
    required this.mood,
    this.aiAnalysis,
  });
}
