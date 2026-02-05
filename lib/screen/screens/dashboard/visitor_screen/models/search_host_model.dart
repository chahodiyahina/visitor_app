// To parse this JSON data, do
//
//     final searchHostModel = searchHostModelFromJson(jsonString);

import 'dart:convert';

SearchHostModel searchHostModelFromJson(String str) => SearchHostModel.fromJson(json.decode(str));

String searchHostModelToJson(SearchHostModel data) => json.encode(data.toJson());

class SearchHostModel {
  int? status;
  List<UserList>? userList;

  SearchHostModel({
    this.status,
    this.userList,
  });

  factory SearchHostModel.fromJson(Map<String, dynamic> json) => SearchHostModel(
    status: json["status"],
    userList: json["user_list"] == null ? [] : List<UserList>.from(json["user_list"]!.map((x) => UserList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "user_list": userList == null ? [] : List<dynamic>.from(userList!.map((x) => x.toJson())),
  };
}

class UserList {
  String? username;
  String? email;
  String? name;
  dynamic usercode;
  dynamic userSite;
  String? mobileNumber;
  bool? isStaff;
  bool? isSecurity;
  DateTime? lastLogin;
  int? id;
  String? password;
  dynamic sortname;
  String? department;
  dynamic siteGateNumber;
  bool? isActive;
  bool? isSuperuser;
  DateTime? dateJoined;

  UserList({
    this.username,
    this.email,
    this.name,
    this.usercode,
    this.userSite,
    this.mobileNumber,
    this.isStaff,
    this.isSecurity,
    this.lastLogin,
    this.id,
    this.password,
    this.sortname,
    this.department,
    this.siteGateNumber,
    this.isActive,
    this.isSuperuser,
    this.dateJoined,
  });

  factory UserList.fromJson(Map<String, dynamic> json) => UserList(
    username: json["username"],
    email: json["email"],
    name: json["name"],
    usercode: json["usercode"],
    userSite: json["userSite"],
    mobileNumber: json["mobileNumber"],
    isStaff: json["is_staff"],
    isSecurity: json["is_security"],
    lastLogin: json["last_login"] == null ? null : DateTime.parse(json["last_login"]),
    id: json["id"],
    password: json["password"],
    sortname: json["sortname"],
    department: json["department"],
    siteGateNumber: json["siteGateNumber"],
    isActive: json["is_active"],
    isSuperuser: json["is_superuser"],
    dateJoined: json["date_joined"] == null ? null : DateTime.parse(json["date_joined"]),
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "email": email,
    "name": name,
    "usercode": usercode,
    "userSite": userSite,
    "mobileNumber": mobileNumber,
    "is_staff": isStaff,
    "is_security": isSecurity,
    "last_login": lastLogin?.toIso8601String(),
    "id": id,
    "password": password,
    "sortname": sortname,
    "department": department,
    "siteGateNumber": siteGateNumber,
    "is_active": isActive,
    "is_superuser": isSuperuser,
    "date_joined": dateJoined?.toIso8601String(),
  };
}
