// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool? success;
  String? message;
  String? accessToken;
  String? tokenType;
  User? user;

  LoginModel({
    this.success,
    this.message,
    this.accessToken,
    this.tokenType,
    this.user,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    success: json["success"],
    message: json["message"],
    accessToken: json["access_token"],
    tokenType: json["token_type"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "access_token": accessToken,
    "token_type": tokenType,
    "user": user?.toJson(),
  };
}

class User {
  int? id;
  String? email;
  String? name;
  bool? isActive;
  String? userType;
  dynamic department;
  String? userSite;
  String? siteGateNumber;

  User({
    this.id,
    this.email,
    this.name,
    this.isActive,
    this.userType,
    this.department,
    this.userSite,
    this.siteGateNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    name: json["name"],
    isActive: json["is_active"],
    userType: json["user_type"],
    department: json["department"],
    userSite: json["userSite"],
    siteGateNumber: json["siteGateNumber"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "is_active": isActive,
    "user_type": userType,
    "department": department,
    "userSite": userSite,
    "siteGateNumber": siteGateNumber,
  };
}
