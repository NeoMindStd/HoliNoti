import 'dart:convert';

class Notification {
  String title;
  String body;

  Notification({this.title = "", this.body = ""});

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        title: json['title'] as String ?? "",
        body: json['body'] as String ?? "",
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'body': body,
      };

  @override
  String toString() => 'Notification{title: $title, body: $body}';
}

Notification notificationFromJson(String string) =>
    Notification.fromJson(json.decode(string));

String notificationToJson(Notification notification) =>
    json.encode(notification.toJson());
