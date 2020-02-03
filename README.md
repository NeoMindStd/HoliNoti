# Holinoti
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/dwyl/esta/issues) 
[![HitCount](http://hits.dwyl.io/NeoMindStd/Holinoti.svg)](http://hits.dwyl.io/NeoMindStd/Holinoti)

**Admin** [![Known Vulnerabilities](https://snyk.io/test/github/NeoMindStd/Holinoti/badge.svg?targetFile=holinoti_admin/android/app/build.gradle)](https://snyk.io/test/github/NeoMindStd/Holinoti?targetFile=holinoti_admin/android/app/build.gradle) 
**Customer** [![Known Vulnerabilities](https://snyk.io/test/github/NeoMindStd/Holinoti/badge.svg?targetFile=holinoti_customer/android/app/build.gradle)](https://snyk.io/test/github/NeoMindStd/Holinoti?targetFile=holinoti_customer/android/app/build.gradle) 

## Korean
가게나 공공시설등의 비정기 휴일 또는 영업일을 파악하여 계획의 차질을 방지하기 위해 시작된 오픈소스 프로젝트입니다.
**정식 릴리즈되지 않은 코드를 빌드, 사용시 어떠한 법적 책임도 지지 않음을 명시합니다.**
[기타 라이센스 관련 사항은 이곳을 참고해주세요](https://github.com/NeoMindStd/Holinoti/blob/master/LICENSE)
#### 프로젝트에 대해서
주변 맛집, 카페, PC방, 도서관이 갑자기 여행, 공사 등의 이유로 임시 휴일일 때 헛걸음 하신적 있으신가요?
가게에 휴일공지도 하고, 조금 큰 시설의 경우 자체적으로 공지도 하지만 통합적인 공지 플랫폼이 없어 난처했던 경험 많이들 하셨을 것으로 생각합니다.
이 프로젝트는 그런 경험을 최소화하기 위해 시작되었습니다.

## English
It is an open source project started as for identifying irregular holidays or business day such as shops and public facilities to prevent failure of plans.
**IT ASSUMES TO NO LIABILITY WHATSOEVER FOR UNOFFICIAL RELEASE.**
[See here for other license details](https://github.com/NeoMindStd/Holinoti/blob/master/LICENSE)
#### About the project
Have you ever go to a restaurant, cafe, PC room, or library when is on a temporary holiday due to sudden travel or construction?
It's a shit.
The project was started to minimize such experience.

## Versions of tools

### CLIENTS
- Framework: Flutter 1.12.13+hotfix.7 • channel stable
- IDE: Android Studio 3.5.3 JRE: 1.8 (use androidx.* artifacts) 
- Language: Dart 2.5.0
- App native languages
  * android: Java 1.8 (Gradle 5.6.4 build, plugin 3.5.3), Kotlin 1.3.10
  * iOS: Swift

### SERVER 
- Framework: Spring boot Starter Parent 2.1.12.RELEASE
- IDE: IntelliJ IDEA 2019.3.2 (Ultimate Edition) 
- Language: Open JDK 11 (Maven 3.6.1 build)
- DB: 5.7.28 MySQL Community Server
- WAS: Apache Tomcat 9.0.27
- Host: Google Cloud Platform
- Server OS: CentOS Linux release 7.7.1908

## TODO List
#### 공통(General)
- 사용한 오픈소스 라이브러리 표기 (Add the licenses page)
- 개인정보 처리방침 등록 (Add the privacy policy page)
- REST API 이용 보안 키 등록 (Change to use security key for rest api)

#### 서버(Server)
- 로그인 시 서버에서 처리 후 토큰 교환하는 방식으로 변경 (Change the login method to use tokens)
- 데이터베이스에 비밀번호 저장 시 SHA 해싱 암호화 적용 (Apply SHA hashing encryption when storing passwords in the database)

#### 관리자용 앱(App for Admin)
- 비밀번호 입력 칸 암호처리 및 입력 값 검증 (Change password input field to blind characters and check input value)
- 가게 수정 및 삭제, 운영시간 수정 및 삭제, 회원정보 관리 및 회원 탈퇴기능 도입 (Implement features that edit and delete facilities, update and delete operating hours, manage member information and membership withdrawal)
- 비정기 휴일, 영업일 등록기능 도입 (Implement a feature that register irregular holiday and business day)

#### 고객용 앱(App for Customer)
- 가게 즐겨찾기 기능 추가 (Implement a feature that facilities favorites)
- 비정기 휴일, 영업일 등록 시 푸시 알림 예약기능 추가 - 서버 단 (Implement a feature that add push notification when registered irregular holiday and business day - server side)
