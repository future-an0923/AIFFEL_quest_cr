# AIFFEL Campus Online Code Peer Review Templete
- 코더 : 안진용
- 리뷰어 : 이윤환


# PRT(Peer Review Template)
- [x]  **1. 주어진 문제를 해결하는 완성된 코드가 제출되었나요?**   
    문제 1.   
    <img width="858" alt="image" src="https://github.com/user-attachments/assets/6cf600b5-398a-43fe-b53f-f887b134fcb7" />   
    문제 2.   
    <img width="626" alt="image" src="https://github.com/user-attachments/assets/53823e72-481e-4c87-937c-bb608def86b0" />   
    
- [x]  **2. 전체 코드에서 가장 핵심적이거나 가장 복잡하고 이해하기 어려운 부분에 작성된 
주석 또는 doc string을 보고 해당 코드가 잘 이해되었나요?**   
    - 데코레이터를 위한 코드가 잘 정리되었으며, count를 위한 nonlocal 사용이 적절해 보임.   
    - <img width="626" alt="image" src="https://github.com/user-attachments/assets/2568c2fb-30e6-4217-894e-75c69a3b816b" />   

    
- [x]  **3. 에러가 난 부분을 디버깅하여 문제를 해결한 기록을 남겼거나
새로운 시도 또는 추가 실험을 수행해봤나요?**   
    - <img width="891" alt="image" src="https://github.com/user-attachments/assets/71d9d46d-d6b0-418c-8c77-e54d28560f4c" />

        
- [x]  **4. 회고를 잘 작성했나요?**
    - PRT 3번 캡쳐와 동일합니다.   

        
- [x]  **5. 코드가 간결하고 효율적인가요?**
    - PRT 1 캡쳐와 동일합니다.


# 회고(참고 링크 및 코드 개선)
```
# 리뷰어의 회고를 작성합니다.
# 코드 리뷰 시 참고한 링크가 있다면 링크와 간략한 설명을 첨부합니다.
# 코드 리뷰를 통해 개선한 코드가 있다면 코드와 간략한 설명을 첨부합니다.   
```
문제를 해결하기 위해서 많은 고민을 한 흔적들이 발견되는 것 같습니다. 저도 더 깊게 고민하는 연습을 할 필요가 있다고 느껴집니다. 그리고 개인적으로 디버깅과 관련해서 코드 안에 주석으로 추가해주시면 이해하기 더 쉬울 것 같습니다. 수고하셨습니다.   
1. min, max value의 초기값 설정하는 코드가 중복되는 것으로 보입니다. 예를 들어 min_value = 0 과 min_value = float(-inf) 둘 중 하나만 사용하셔도 될 것 같습니다.
  
<코더 코드>   
<img width="688" alt="image" src="https://github.com/user-attachments/assets/a1fe8a3b-40f6-47c2-85d0-30ca05791174" />

<참고 코드>   
<img width="688" alt="image" src="https://github.com/user-attachments/assets/c7af6ca3-20d1-439f-b7f5-c1001e67df91" />
  
2. 이미 nonlocal을 통해 min, max 값 업데이트가 자연스럽게 진행되므로, min_value = min(numbers)는 생략해도 될 것 같습니다.
   
<코더 코드>       
<img width="688" alt="image" src="https://github.com/user-attachments/assets/daddaf01-2ccd-4057-a236-228607b9d903" />
 
<참고 코드>  
<img width="688" alt="image" src="https://github.com/user-attachments/assets/ca1ade6f-48ae-40e5-9506-3b14c008503b" />

