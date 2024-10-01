# travel

여행객들을 위한 앱을 만들 계획임

# 기획

> 일기

- 여행을 하고 일기(?)를 포스팅 형태로 작성
- 이 때 시간과 위치, 해시태그 등을 추가
- 공유기능을 통해서 좋아요 댓글 기능 추가함

> Image2Text

- 이미지에서 텍스트를 추출하고, 이를 번역하는 기능
- 번역 기능을 google ml kit로 코드 작성하였는데 모델 다운로드에 시간이 매우 오래걸림
- gemeni api를 사용하는 방식으로 개선할 필요가 있음

# Reference

    > Google ML Kit 

    - Image To Text

        https://pub.dev/packages/google_mlkit_text_recognition