# Holinoti
![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)
![HitCount](http://hits.dwyl.io/NeoMindStd/Holinoti.svg)

| Sub Project | Platform | Vulnerabilities | CI |
|:---:|:---:|:---:|:---:|
| **App for Admin** | ![platform](https://img.shields.io/badge/platform-flutter-blue) | ![Known Vulnerabilities](https://snyk.io/test/github/NeoMindStd/Holinoti/badge.svg?targetFile=holinoti_admin/android/app/build.gradle) | ![Flutter CI - Admin](https://github.com/NeoMindStd/HoliNoti/workflows/Flutter%20CI%20-%20Admin/badge.svg) |
| **App for Customer** | ![platform](https://img.shields.io/badge/platform-flutter-blue) | ![Known Vulnerabilities](https://snyk.io/test/github/NeoMindStd/Holinoti/badge.svg?targetFile=holinoti_customer/android/app/build.gradle) | ![Flutter CI - Customer](https://github.com/NeoMindStd/HoliNoti/workflows/Flutter%20CI%20-%20Customer/badge.svg) |
| **Server** | ![platform](https://img.shields.io/badge/platform-spring_boot-green) | ![Known Vulnerabilities](https://snyk.io/test/github/NeoMindStd/Holinoti/badge.svg?targetFile=holinoti_server/pom.xml) | ![Java Maven CI](https://github.com/NeoMindStd/HoliNoti/workflows/Java%20Maven%20CI/badge.svg) |

<br>

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
- Framework: Flutter 1.12.13+hotfix.8 • channel stable
- IDE: Android Studio 3.6.1 JRE: 1.8 (use androidx.* artifacts) 
- Language: Dart 2.7.1
- App native languages
  * android: Java 1.8 (Gradle 5.6.4 build, plugin 3.5.3), Kotlin 1.3.10
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