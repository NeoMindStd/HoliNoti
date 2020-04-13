Language: [한국어](README.md) | [ENGLISH](README-EN.md)

# Holinoti
![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)
![HitCount](http://hits.dwyl.io/NeoMindStd/Holinoti.svg)

| Sub Project | Platform | Vulnerabilities | CI |
|:---:|:---:|:---:|:---:|
| **App for Admin** | ![platform](https://img.shields.io/badge/platform-flutter-blue) | ![Known Vulnerabilities](https://snyk.io/test/github/NeoMindStd/Holinoti/badge.svg?targetFile=holinoti_admin/android/app/build.gradle) | ![Flutter CI - Admin](https://github.com/NeoMindStd/HoliNoti/workflows/Flutter%20CI%20-%20Admin/badge.svg) |
| **App for Customer** | ![platform](https://img.shields.io/badge/platform-flutter-blue) | ![Known Vulnerabilities](https://snyk.io/test/github/NeoMindStd/Holinoti/badge.svg?targetFile=holinoti_customer/android/app/build.gradle) | ![Flutter CI - Customer](https://github.com/NeoMindStd/HoliNoti/workflows/Flutter%20CI%20-%20Customer/badge.svg) |
| **Server** | ![platform](https://img.shields.io/badge/platform-spring_boot-green) | ![Known Vulnerabilities](https://snyk.io/test/github/NeoMindStd/Holinoti/badge.svg?targetFile=holinoti_server/pom.xml) | ![Java Maven CI](https://github.com/NeoMindStd/HoliNoti/workflows/Java%20Maven%20CI/badge.svg) |

<br>

## 소개
가게나 공공시설등의 비정기 휴일 또는 영업일을 파악하여 계획의 차질을 방지하기 위해 시작된 오픈소스 프로젝트입니다.
**정식 릴리즈되지 않은 코드를 빌드, 사용시 어떠한 법적 책임도 지지 않음을 명시합니다.**
[기타 라이센스 관련 사항은 이곳을 참고해주세요](https://github.com/NeoMindStd/Holinoti/blob/master/LICENSE)
#### 프로젝트에 대해서
주변 맛집, 카페, PC방, 도서관이 갑자기 여행이나 공사 등의 이유로 임시 휴일일 때 헛걸음한 경험을 한 번쯤은 갖고 있을 것입니다. 가게의 문이나 창문에 휴업 공지를 하고, 도서관 등의 큰 시설은 자체적인 홈페이지 등의 플랫폼으로 공지하고 있지만, 통합적인 공지 플랫폼이 없어 일일이 확인하기 귀찮고, 자그마한 가게나 식당의 경우 이러한 공지 플랫폼마저 없어 확인할 방법이 없습니다. 이 프로젝트를 통해 이런 난처한 경험을 줄이고, 일정과 동선을 계획할 때 방문할 시설의 휴업 여부를 고려할 수 있도록 하여 시간과 비용을 절약할 수 있을 것으로 기대합니다.

## 개발 환경

### CLIENTS
- Framework: Flutter 1.12.13+hotfix.9 • channel stable
- IDE: Android Studio 3.6.2 JRE: 1.8 (use androidx.* artifacts) 
- Language: Dart 2.7.1
- App native languages
  * android: Open JDK 11 (Gradle 6.3 build, plugin 3.6.2), Kotlin 1.3.10
  * android-ndk: 21.0.6113669
  * iOS: Swift

### SERVER 
- Framework: Spring boot Starter Parent 2.1.12.RELEASE
- IDE: IntelliJ IDEA 2019.3.3 (Ultimate Edition) 
- Language: Open JDK 11 (Maven 3.6.1 build)
- DB: 5.7.28 MySQL Community Server
- WAS: Apache Tomcat 9.0.27
- Host: Google Cloud Platform
- Server OS: CentOS Linux release 7.7.1908

## [BACKLOG](/BACKLOG.md)