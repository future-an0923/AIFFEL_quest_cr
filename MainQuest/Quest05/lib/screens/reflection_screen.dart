import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/reflection.dart';
import '../providers/reflection_provider.dart';

class ReflectionScreen extends StatefulWidget {
  @override
  _ReflectionScreenState createState() => _ReflectionScreenState();
}

class _ReflectionScreenState extends State<ReflectionScreen> {
  final Map<String, TextEditingController> _controllers = {};
  String _selectedMood = '😊'; // 기본 기분
  final _formKey = GlobalKey<FormState>();
  // 현재 불러온 회고의 ID를 저장하는 변수 추가
  String? _currentReflectionId;

  // 그리드 형태의 회고 질문들
  final List<Map<String, String>> _reflectionPrompts = [
    {'id': 'grateful', 'question': '오늘 기억에 남는 일은 무엇인가요?'},
    {'id': 'learn', 'question': '오늘 배운 것은 무엇인가요?'},
    {'id': 'challenge', 'question': '오늘의 목표는 무엇이었나요?'},
    {'id': 'tomorrow', 'question': '오늘 달성하지 목표는 무엇인가요?'},
  ];

  // 기분 이모지 목록
  final List<String> _moods = ['😊', '😐', '😢', '😡'];

  @override
  void initState() {
    super.initState();
    // 각 질문에 대한 컨트롤러 초기화
    for (var prompt in _reflectionPrompts) {
      _controllers[prompt['id']!] = TextEditingController();
    }

    // 오늘 날짜의 회고가 있으면 불러오기
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final reflectionProvider = Provider.of<ReflectionProvider>(
        context,
        listen: false,
      );
      final todayReflection = reflectionProvider.getReflectionByDate(
        DateTime.now(),
      );

      if (todayReflection != null) {
        // 기존 회고 데이터로 필드 채우기
        setState(() {
          _currentReflectionId = todayReflection.id; // 회고 ID 저장
          _selectedMood = todayReflection.mood;
          todayReflection.answers.forEach((id, answer) {
            if (_controllers.containsKey(id)) {
              _controllers[id]!.text = answer;
            }
          });
        });
      }
    });
  }

  @override
  void dispose() {
    // 컨트롤러 해제
    _controllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  // 회고 삭제 확인 대화상자를 표시하는 메서드
  Future<bool> _confirmDelete() async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('회고 삭제'),
              content: Text('오늘의 회고를 삭제하시겠습니까?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('취소'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('삭제'),
                ),
              ],
            );
          },
        ) ??
        false; // null 반환 시 false로 처리
  }

  // 회고 삭제 메서드
  void _deleteReflection() async {
    if (_currentReflectionId != null) {
      final confirm = await _confirmDelete();

      if (confirm) {
        // 회고 삭제
        Provider.of<ReflectionProvider>(
          context,
          listen: false,
        ).deleteReflection(_currentReflectionId!);

        // 필드 초기화
        setState(() {
          _currentReflectionId = null;
          _selectedMood = '😊';
          _controllers.forEach((_, controller) => controller.clear());
        });

        // 삭제 알림 표시
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('오늘의 회고가 삭제되었습니다')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateStr = '${now.year}년 ${now.month}월 ${now.day}일';

    return Scaffold(
      appBar: AppBar(
        title: Text('오늘의 회고'),
        actions: [
          // 기존 회고가 있는 경우에만 삭제 버튼 표시
          if (_currentReflectionId != null)
            IconButton(icon: Icon(Icons.delete), onPressed: _deleteReflection),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 날짜 표시
              Text(
                dateStr,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              // 기분 선택
              Text(
                '오늘의 기분',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:
                    _moods.map((mood) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedMood = mood;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                _selectedMood == mood
                                    ? Colors.blue
                                    : Colors.white,
                          ),
                          child: Text(mood, style: TextStyle(fontSize: 24)),
                        ),
                      );
                    }).toList(),
              ),
              SizedBox(height: 20),

              // 그리드 형태의 질문 필드
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: _reflectionPrompts.length,
                  itemBuilder: (context, index) {
                    final prompt = _reflectionPrompts[index];
                    return Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              prompt['question']!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Expanded(
                              child: TextFormField(
                                controller: _controllers[prompt['id']],
                                maxLines: null,
                                decoration: InputDecoration(
                                  hintText: '입력하는 곳',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // 저장 버튼
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveReflection,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      _currentReflectionId == null ? '회고 저장하기' : '회고 업데이트하기',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveReflection() {
    if (_formKey.currentState!.validate()) {
      // 회고 데이터 생성
      Map<String, String> answers = {};
      _controllers.forEach((id, controller) {
        answers[id] = controller.text;
      });

      // 회고 객체 생성
      final reflection = Reflection(
        id:
            _currentReflectionId ??
            const Uuid().v4(), // 기존 ID가 있으면 사용, 없으면 새로 생성
        date: DateTime.now(),
        answers: answers,
        mood: _selectedMood,
      );

      // Provider를 통해 저장
      Provider.of<ReflectionProvider>(
        context,
        listen: false,
      ).addReflection(reflection);

      // 현재 회고 ID 업데이트
      setState(() {
        _currentReflectionId = reflection.id;
      });

      // 저장 완료 메시지
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('오늘의 회고가 저장되었습니다')));
    }
  }
}
