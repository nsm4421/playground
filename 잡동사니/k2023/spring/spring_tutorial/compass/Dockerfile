# Base이미지 이름
FROM openjdk:11

# 변수 선언 - JAR_FILE에 app.jar 파일이 저장된 경로 지정
ARG JAR_FILE=build/libs/app.jar

# app.jar를 Dokcer container로 복사
COPY ${JAR_FILE} ./app.jar

# 실행환경 - TimeZone은 서울시간
ENV TZ=Asia/Seoul

# Docker 시작시 java -jar ./app.jar 명령어 실행
ENTRYPOINT ["java","-jar","./app.jar"]
