import 'dart:async';

void main() {
  PomodoroTimer().start();
}

class PomodoroTimer {
  // 작업 시간 (분 단위)
  int workTime = 25;
  // 짧은 휴식 시간 (분 단위)
  int shortBreakTime = 5;
  // 긴 휴식 시간 (분 단위)
  int longBreakTime = 15;
  // 완료된 작업 사이클 횟수
  int cycleCount = 0;

  // 타이머 시작 메서드
  void start() {
    print("Pomodoro 타이머를 시작합니다.");
    _startWorkTimer(); // 작업 타이머 시작
  }

  // 작업 시간 타이머 관리
  void _startWorkTimer() {
    int minutesLeft = workTime; // 남은 작업 시간
    Timer.periodic(Duration(minutes: 1), (timer) {
      if (minutesLeft == 0) {
        timer.cancel(); // 타이머 종료
        cycleCount++; // 사이클 카운트 증가
        print("작업 시간이 끝났어요!");
        
        // 4회차마다 긴 휴식 적용
        if (cycleCount % 4 == 0) {
          print("4번째 작업 완료! 15분 쉬기 시작합니다.");
          _startBreakTimer(longBreakTime); // 긴 휴식 시작
        } else {
          print("쉬는 시간 시작 (5분)");
          _startBreakTimer(shortBreakTime); // 짧은 휴식 시작
        }
      } else {
        print("작업 중: $minutesLeft분 남음");
        minutesLeft--; // 매분 감소
      }
    });
  }

  // 휴식 시간 타이머 관리
  void _startBreakTimer(int breakTime) {
    int minutesLeft = breakTime; // 남은 휴식 시간
    Timer.periodic(Duration(minutes: 1), (timer) {
      if (minutesLeft == 0) {
        timer.cancel(); // 타이머 종료
        print("쉬는 시간이 끝났어요! 다시 작업 시작!");
        _startWorkTimer(); // 작업 타이머 재시작
      } else {
        print("쉬는 중: $minutesLeft분 남음");
        minutesLeft--; // 매분 감소
      }
    });
  }
}
// https://medium.com/@ai-den/flutter-timer%EC%99%80-ticker-6a4d19f81819
// https://wikidocs.net/168330
// https://stackoverflow.com/questions/78042633/how-to-turn-flutter-seconds-into-minutes-and-seconds
