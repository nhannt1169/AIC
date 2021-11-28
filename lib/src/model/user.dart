// To parse this JSON data, do
//
//     final userMessage = userMessageFromJson(jsonString);

import 'dart:convert';

UserMessage userMessageFromJson(String str) =>
    UserMessage.fromJson(json.decode(str));

String userMessageToJson(UserMessage data) => json.encode(data.toJson());

class UserMessage {
  UserMessage({
    this.data,
    this.user,
    this.statusCode,
  });

  String? data;
  User? user;
  int? statusCode;

  factory UserMessage.fromJson(Map<String, dynamic> json) => UserMessage(
        data: json["data"],
        user: User.fromJson(json["user"]),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "user": user!.toJson(),
        "statusCode": statusCode,
      };
}

class User {
  User({this.id, this.name, this.avatar, this.phone, this.role, this.email});

  String? id;
  String? name;
  String? avatar;
  String? phone;
  String? role;
  String? email;

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json[
          "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier"],
      name: json["http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"],
      avatar: json[""],
      role:
          json["http://schemas.microsoft.com/ws/2008/06/identity/claims/role"],
      email: json[
          "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"]);

  Map<String, dynamic> toJson() => {
        "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier":
            id,
        "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name": name,
        "avatar": avatar,
        "phone": phone,
        "role": role,
      };
}
