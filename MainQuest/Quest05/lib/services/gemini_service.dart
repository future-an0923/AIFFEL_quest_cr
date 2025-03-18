import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

class GeminiService {
  final String apiKey;
  final String baseUrl = 'https://generativelanguage.googleapis.com/v1beta';
  final String model = 'gemini-1.5-pro';

  GeminiService({required this.apiKey});

  Future<Map<String, dynamic>> analyzeReflection(
    Map<String, String> reflectionData,
    String mood,
  ) async {
    final apiKey = dotenv.dotenv.env['GEMINI_API_KEY'];

    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('API 키가 설정되지 않았습니다');
    }

    String reflectionText = '';
    reflectionData.forEach((key, value) {
      String question = '';
      switch (key) {
        case 'grateful':
          question = '오늘 기억에 남는 일';
          break;
        case 'learn':
          question = '오늘 배운 것';
          break;
        case 'challenge':
          question = '오늘의 목표';
          break;
        case 'tomorrow':
          question = '오늘 달성하지 못한 목표';
          break;
      }
      reflectionText += '$question: $value\n';
    });

    reflectionText += '오늘의 기분: $mood\n';

    final body = jsonEncode({
      'contents': [
        {
          'parts': [
            {
              'text':
                  '''다음은 내 오늘의 회고입니다. 이를 분석하고 다음 세 가지 카테고리로 나누어 인사이트를 제공해주세요:
1. 인사이트: 회고에서 발견된 주요 통찰
2. 패턴: 생각이나 행동의 패턴
3. 제안: 성장을 위한 구체적인 제안

회고 내용:
$reflectionText''',
            },
          ],
        },
      ],
      'generationConfig': {'temperature': 0.7, 'maxOutputTokens': 1000},
    });

    try {
      final url = '$baseUrl/models/$model:generateContent?key=$apiKey';
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content = data['candidates'][0]['content']['parts'][0]['text'];
        return _parseGeminiResponse(content);
      } else {
        throw Exception(
          'API 요청 실패: ${response.statusCode}, 응답: ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('API 요청 중 오류 발생: $e');
    }
  }

  Map<String, dynamic> _parseGeminiResponse(String content) {
    final Map<String, dynamic> result = {
      'insights': [],
      'patterns': [],
      'suggestions': [],
    };

    final lines = content.split('\n');
    String currentSection = '';

    for (var line in lines) {
      if (line.contains('인사이트') || line.contains('Insight')) {
        currentSection = 'insights';
        continue;
      } else if (line.contains('패턴') || line.contains('Pattern')) {
        currentSection = 'patterns';
        continue;
      } else if (line.contains('제안') || line.contains('Suggestion')) {
        currentSection = 'suggestions';
        continue;
      }

      if (line.trim().isNotEmpty && currentSection.isNotEmpty) {
        if (!result[currentSection].contains(line.trim())) {
          result[currentSection].add(line.trim());
        }
      }
    }

    return result;
  }
}
