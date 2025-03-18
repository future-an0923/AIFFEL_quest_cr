### 1. 기획 및 디자인
- 앱 주제 선정: 할 일 관리 및 회고 앱

- 기본 기능 정의: 할 일 목록 관리, 회고 작성 및 분석
- 정보구조도
  
 ![정보구조도](https://github.com/user-attachments/assets/7f820ba4-2537-44f3-b473-7bb5c7634067)

- 와이어프레임

![KakaoTalk_20250318_154553762](https://github.com/user-attachments/assets/c1b8386d-1fa7-4c9f-a1eb-f82b48d3dc63)



### 2. 기본 기능 구현
- 프로젝트 생성 및 기본 구조 설정

- 메인 페이지 UI 구현 (HomeScreen)

  ![homescreen](https://github.com/user-attachments/assets/c71b6e0d-cc9a-48dc-987d-bacc0a2542ee)


- 데이터 모델 클래스 정의 (Todo, Reflection)

- Provider를 사용한 상태 관리 구조 구현

### 3. 네비게이션 및 데이터 전달
- 페이지 간 네비게이션 구현 (예: 할 일 추가, 회고 작성 화면으로 이동)

![할일추가](https://github.com/user-attachments/assets/f459a564-e194-4926-96ae-a4b40f898eb5)
![회고작성](https://github.com/user-attachments/assets/0c06d203-ab4f-4c60-a009-3200fc56be93)

- Provider를 통한 데이터 전달 메커니즘 구현

- 상세 페이지 UI 및 기능 구현 (TodoDetailScreen, ReflectionScreen)

### 4. 고급 기능 통합
- 사용자 입력 처리 및 데이터 저장 (할 일 추가, 회고 작성)

![회고 기록](https://github.com/user-attachments/assets/4bf703d2-5f53-46c5-91ac-fe244a283578)
![회고내용](https://github.com/user-attachments/assets/7daace9b-954b-44f4-b5a8-518c75e8e87c)



- UI/UX 개선 (예: 완료된 할 일 표시, 회고 분석 결과 표시)

![완료된 할일 표시](https://github.com/user-attachments/assets/b62f2d2a-f8cf-4c7e-aac0-3e4a8ec990cc)
![회고 분석](https://github.com/user-attachments/assets/d31ea8ee-5d6a-4ebb-bb35-43e600859bbb)


### 5. API 및 외부 서비스 연동
- Google Gemini API를 사용한 회고 분석 기능 구현

- 환경 변수를 통한 API 키 관리
