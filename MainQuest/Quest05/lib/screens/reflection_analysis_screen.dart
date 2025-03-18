import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/reflection.dart';
import '../providers/reflection_provider.dart';
import '../services/gemini_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

class ReflectionAnalysisScreen extends StatefulWidget {
  final Reflection reflection;

  ReflectionAnalysisScreen({required this.reflection});

  @override
  _ReflectionAnalysisScreenState createState() =>
      _ReflectionAnalysisScreenState();
}

class _ReflectionAnalysisScreenState extends State<ReflectionAnalysisScreen> {
  bool _isLoading = false;
  Map<String, dynamic>? _analysis;

  @override
  void initState() {
    super.initState();
    _analysis = widget.reflection.aiAnalysis;
    if (_analysis == null) {
      _analyzeReflection();
    }
  }

  Future<void> _analyzeReflection() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // 환경 변수나 안전한 저장소에서 API 키 가져오기
      final apiKey = dotenv.dotenv.env['GEMINI_API_KEY'];
      if (apiKey == null) {
        throw Exception('GEMINI_API_KEY not found in environment variables');
      }
      final geminiService = GeminiService(apiKey: apiKey);
      final analysis = await geminiService.analyzeReflection(
        widget.reflection.answers,
        widget.reflection.mood,
      );

      setState(() {
        _analysis = analysis;
        _isLoading = false;
      });

      // 분석 결과 저장
      Provider.of<ReflectionProvider>(
        context,
        listen: false,
      ).updateReflectionWithAIAnalysis(widget.reflection.id, analysis);
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('분석 중 오류가 발생했습니다: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final date = widget.reflection.date;
    final dateStr = '${date.year}년 ${date.month}월 ${date.day}일';

    return Scaffold(
      appBar: AppBar(title: Text('회고 분석')),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : _analysis == null
              ? Center(child: Text('분석 결과가 없습니다'))
              : SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 날짜와 기분 표시
                    Row(
                      children: [
                        Text(
                          dateStr,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          widget.reflection.mood,
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // 인사이트 섹션
                    _buildSection(
                      '인사이트',
                      _analysis!['insights'],
                      Icons.lightbulb_outline,
                      Colors.amber,
                    ),

                    // 패턴 섹션
                    _buildSection(
                      '패턴',
                      _analysis!['patterns'],
                      Icons.repeat,
                      Colors.blue,
                    ),

                    // 제안 섹션
                    _buildSection(
                      '성장을 위한 제안',
                      _analysis!['suggestions'],
                      Icons.trending_up,
                      Colors.green,
                    ),
                  ],
                ),
              ),
    );
  }

  Widget _buildSection(
    String title,
    List<dynamic> items,
    IconData icon,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        ...items.map(
          (item) => Padding(
            padding: EdgeInsets.only(left: 8, bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Expanded(child: Text(item, style: TextStyle(fontSize: 16))),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
