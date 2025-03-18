import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reflection_provider.dart';
import 'reflection_analysis_screen.dart';

class ReflectionHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('회고 기록')),
      body: Consumer<ReflectionProvider>(
        builder: (context, reflectionProvider, child) {
          final reflections = reflectionProvider.reflections;

          if (reflections.isEmpty) {
            return Center(child: Text('아직 회고 기록이 없습니다'));
          }

          // 날짜별로 정렬 (최신순)
          reflections.sort((a, b) => b.date.compareTo(a.date));

          return ListView.builder(
            itemCount: reflections.length,
            itemBuilder: (context, index) {
              final reflection = reflections[index];
              final date = reflection.date;
              final dateStr = '${date.year}년 ${date.month}월 ${date.day}일';

              // Dismissible로 스와이프하여 삭제 기능 추가
              return Dismissible(
                key: Key(reflection.id),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                direction: DismissDirection.endToStart,
                confirmDismiss: (direction) async {
                  // 삭제 확인 대화상자 표시
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('회고 삭제'),
                        content: Text('이 회고를 삭제하시겠습니까?'),
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
                  );
                },
                onDismissed: (direction) {
                  // 회고 삭제
                  reflectionProvider.deleteReflection(reflection.id);
                  // 삭제 알림 표시
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$dateStr 회고가 삭제되었습니다')),
                  );
                },
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ExpansionTile(
                    leading: Text(
                      reflection.mood,
                      style: TextStyle(fontSize: 24),
                    ),
                    title: Text(dateStr),
                    // 확장 시 표시될 내용
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              reflection.answers.entries.map((entry) {
                                // 질문 ID에 해당하는 질문 텍스트 찾기
                                String question = '';
                                switch (entry.key) {
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

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        question,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(entry.value),
                                    ],
                                  ),
                                );
                              }).toList(),
                        ),
                      ),
                      // 버튼 행 추가
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 16.0,
                          right: 16.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // AI 분석 버튼 추가
                            TextButton.icon(
                              icon: Icon(Icons.analytics, color: Colors.blue),
                              label: Text(
                                'AI 분석',
                                style: TextStyle(color: Colors.blue),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => ReflectionAnalysisScreen(
                                          reflection: reflection,
                                        ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(width: 16),
                            // 삭제 버튼
                            TextButton.icon(
                              icon: Icon(Icons.delete, color: Colors.red),
                              label: Text(
                                '삭제',
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () async {
                                // 삭제 확인 대화상자 표시
                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('회고 삭제'),
                                      content: Text('이 회고를 삭제하시겠습니까?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed:
                                              () => Navigator.of(
                                                context,
                                              ).pop(false),
                                          child: Text('취소'),
                                        ),
                                        TextButton(
                                          onPressed:
                                              () => Navigator.of(
                                                context,
                                              ).pop(true),
                                          child: Text('삭제'),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                if (confirm == true) {
                                  // 회고 삭제
                                  reflectionProvider.deleteReflection(
                                    reflection.id,
                                  );
                                  // 삭제 알림 표시
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('$dateStr 회고가 삭제되었습니다'),
                                    ),
                                  );
                                  // ExpansionTile 접기 (Navigator.pop은 필요 없음)
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
