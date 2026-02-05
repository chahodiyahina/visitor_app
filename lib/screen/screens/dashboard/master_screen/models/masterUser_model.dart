// To parse this JSON data, do
//
//     final masterUserModel = masterUserModelFromJson(jsonString);

import 'dart:convert';

MasterUserModel masterUserModelFromJson(String str) => MasterUserModel.fromJson(json.decode(str));

String masterUserModelToJson(MasterUserModel data) => json.encode(data.toJson());

class MasterUserModel {
  bool? status;
  int? total;
  List<Datum>? data;

  MasterUserModel({
    this.status,
    this.total,
    this.data,
  });

  factory MasterUserModel.fromJson(Map<String, dynamic> json) => MasterUserModel(
    status: json["status"],
    total: json["total"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "total": total,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  String? username;
  String? email;
  String? name;
  String? department;
  String? userSite;
  String? siteGateNumber;
  String? mobileNumber;
  bool? isActive;
  bool? isStaff;
  bool? isSecurity;
  bool? isSuperuser;
  DateTime? dateJoined;
  DateTime? lastLogin;

  Datum({
    this.id,
    this.username,
    this.email,
    this.name,
    this.department,
    this.userSite,
    this.siteGateNumber,
    this.mobileNumber,
    this.isActive,
    this.isStaff,
    this.isSecurity,
    this.isSuperuser,
    this.dateJoined,
    this.lastLogin,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    name: json["name"],
    department: json["department"],
    userSite: json["userSite"],
    siteGateNumber: json["siteGateNumber"],
    mobileNumber: json["mobileNumber"],
    isActive: json["is_active"],
    isStaff: json["is_staff"],
    isSecurity: json["is_security"],
    isSuperuser: json["is_superuser"],
    dateJoined: json["date_joined"] == null ? null : DateTime.parse(json["date_joined"]),
    lastLogin: json["last_login"] == null ? null : DateTime.parse(json["last_login"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "name": name,
    "department": department,
    "userSite": userSite,
    "siteGateNumber": siteGateNumber,
    "mobileNumber": mobileNumber,
    "is_active": isActive,
    "is_staff": isStaff,
    "is_security": isSecurity,
    "is_superuser": isSuperuser,
    "date_joined": dateJoined?.toIso8601String(),
    "last_login": lastLogin?.toIso8601String(),
  };
}
