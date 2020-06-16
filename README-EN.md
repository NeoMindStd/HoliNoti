Language: [한국어](README.md) | [ENGLISH](README-EN.md)

# Holinoti
![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=plastic)
![HitCount](http://hits.dwyl.io/NeoMindStd/Holinoti.svg)

| Sub Project | Platform | Vulnerabilities | CI |
|:---:|:---:|:---:|:---:|
| **App for Admin** | ![platform](https://img.shields.io/badge/platform-flutter-blue) | ![Known Vulnerabilities](https://snyk.io/test/github/NeoMindStd/Holinoti/badge.svg?targetFile=holinoti_admin/android/app/build.gradle) | ![Flutter CI - Admin](https://github.com/NeoMindStd/HoliNoti/workflows/Flutter%20CI%20-%20Admin/badge.svg) |
| **App for Customer** | ![platform](https://img.shields.io/badge/platform-flutter-blue) | ![Known Vulnerabilities](https://snyk.io/test/github/NeoMindStd/Holinoti/badge.svg?targetFile=holinoti_customer/android/app/build.gradle) | ![Flutter CI - Customer](https://github.com/NeoMindStd/HoliNoti/workflows/Flutter%20CI%20-%20Customer/badge.svg) |
| **Server** | ![platform](https://img.shields.io/badge/platform-spring_boot-green) | ![Known Vulnerabilities](https://snyk.io/test/github/NeoMindStd/Holinoti/badge.svg?targetFile=holinoti_server/pom.xml) | ![Java Maven CI](https://github.com/NeoMindStd/HoliNoti/workflows/Java%20Maven%20CI/badge.svg) |

<br>

## Introduction
It is an open source project started as for identifying irregular holidays or business day such as shops and public facilities to prevent failure of plans.
**IT ASSUMES TO NO LIABILITY WHATSOEVER FOR UNOFFICIAL RELEASE.**
[See here for other license details](https://github.com/NeoMindStd/Holinoti/blob/master/LICENSE)

#### About
Have you ever go to a restaurant, cafe, PC room, or library when is on a temporary holiday due to sudden travel or construction?
It's a shit.
The project was started to minimize such experience.

## Dev env

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

## Environment Settings
 create ./holinoti_server/src/main/resources/application.properties and write the below code.
```
server.address=localhost
devtools.livereload.enabled=true
spring.jpa.database=mysql
spring.jpa.generate-ddl=false
spring.datasource.url=jdbc:{your mysql server url}?useUnicode=true&characterEncoding=UTF-8&characterSetResults=UTF-8&useSSL=true
spring.datasource.username={your mysql username}
spring.datasource.password={your mysql password}
spring.datasource.driver-class-name=com.mysql.jdbc.Driver
spring.jpa.database-platform=org.hibernate.spatial.dialect.mysql.MySQL56InnoDBSpatialDialect
spring.datasource.hikari.idle-timeout=10000
spring.datasource.hikari.max-lifetime=420000
spring.datasource.hikari.connection-timeout=10000
spring.datasource.hikari.validation-timeout=10000
spring.jpa.properties.javax.persistence.validation.mode=none
```

## [BACKLOG](/BACKLOG-EN.md)