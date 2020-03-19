Language: [한국어](BACKLOG.md) | [ENGLISH](BACKLOG-EN.md)

# BACKLOG

## USER STORY

#### Network Communication
![](/page_assets/images/network.png)

#### App for Admin
 -This project allows administrators to post basic business hours, business days, etc. of facilities, and super administrators (such as owner) can manage other administrators (such as Alba), and register for the app during temporary holidays due to remodeling, travel, etc. The main goal is to make notice available to customers for viewing.

#### App for Customer
 -This project mainly provides the function to receive alarms when registering temporary holidays by registering the favorites by viewing the opening hours by viewing the facilities (restaurants, parks, libraries, etc.) that customers want. Aim.

These two apps are written in Dart, Java, Kotlin, and Swift and run on Flutter VM.

rxdart and stream are used for state management. (Please avoid stateful widget if possible.)

The design pattern is composed of model(object)-BLoC(business logic)-widget(widget shown on the screen) by applying BLoC (Business Logic Components).

#### DB

![](/page_assets/images/e-r_diagram.png)
![](/page_assets/images/db_schema.png)
![](/page_assets/images/db_schema2.png)

- Use MySQL or MariaDB.
- The main goal is to store and query the data required by the app, and to encrypt and store sensitive personal information such as passwords.
- Transaction optimization and security for processing large amounts of data are additional objectives

#### Processing Server
- The processing server is responsible for processing data requests from the manager app and the customer app. When clients(apps) request data from the server, it is the role of select, update, insert, and delete from the DB server. In addition, we will also be in charge of sending alarms to customer apps when registering temporary holidays in the admin app using firebase.
- It is written in Java on Spring boot framework and runs on Apache Tomcat server. The code is simplified using the Lombok annotation processor, and the MVC pattern is used as the design pattern. The MVC pattern consists of a model-view-controller, but in this project, only the processing server needs to be implemented, so it consists of only the model and the controller, excluding the view.

## TODO LIST

#### General
- Add the licenses page
- Add the privacy policy page
- Change to use security key for rest api

#### App for Admin
- Implement features that edit and delete facilities, update and delete operating hours, manage member information and membership withdrawal
- Implement a feature that register irregular holiday and business day

#### App for Customer
- Implement a feature that facilities favorites
- Implement a feature that add push notification when registered irregular holiday and business day - server side

#### Server
- Change the login method to use tokens