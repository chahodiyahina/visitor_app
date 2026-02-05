// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  int? todayVisitors;
  int? totalTodayActive;
  int? totalTodayCheckOut;
  List<TVisitorList>? currentVisitorList;
  List<TVisitorList>? checkoutVisitorList;
  int? status;

  HomeModel({
    this.todayVisitors,
    this.totalTodayActive,
    this.totalTodayCheckOut,
    this.currentVisitorList,
    this.checkoutVisitorList,
    this.status,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    todayVisitors: json["today_visitors"],
    totalTodayActive: json["total_today_active"],
    totalTodayCheckOut: json["total_today_check_out"],
    currentVisitorList: json["current_visitor_list"] == null ? [] : List<TVisitorList>.from(json["current_visitor_list"]!.map((x) => TVisitorList.fromJson(x))),
    checkoutVisitorList: json["checkout_visitor_list"] == null ? [] : List<TVisitorList>.from(json["checkout_visitor_list"]!.map((x) => TVisitorList.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "today_visitors": todayVisitors,
    "total_today_active": totalTodayActive,
    "total_today_check_out": totalTodayCheckOut,
    "current_visitor_list": currentVisitorList == null ? [] : List<dynamic>.from(currentVisitorList!.map((x) => x.toJson())),
    "checkout_visitor_list": checkoutVisitorList == null ? [] : List<dynamic>.from(checkoutVisitorList!.map((x) => x.toJson())),
    "status": status,
  };
}

class TVisitorList {
  int? id;
  String? badgeNumber;
  String? name;
  String? email;
  String? mobileNumber;
  String? companyName;
  String? vehicleNumber;
  String? vehicleType;
  String? numberOfItems;
  String? itemTypes;
  String? identityProofImage;
  String? host;
  String? department;
  DateTime? date;
  String? time;
  String? createdBy;
  String? createdAt;
  dynamic updatedBy;
  String? updatedAt;
  String? approvedBy;
  String? approvedAt;
  String? duration;
  dynamic rejectedBy;
  dynamic rejectedAt;
  String? checkoutBy;
  String? checkoutAt;
  dynamic checkoutImage;
  String? appointmentStatus;
  String? imagePath;
  int? totalPerson;
  String? entryGate;
  String? entryPlace;

  TVisitorList({
    this.id,
    this.badgeNumber,
    this.name,
    this.email,
    this.mobileNumber,
    this.companyName,
    this.vehicleNumber,
    this.vehicleType,
    this.numberOfItems,
    this.itemTypes,
    this.identityProofImage,
    this.host,
    this.department,
    this.date,
    this.time,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.approvedBy,
    this.approvedAt,
    this.duration,
    this.rejectedBy,
    this.rejectedAt,
    this.checkoutBy,
    this.checkoutAt,
    this.checkoutImage,
    this.appointmentStatus,
    this.imagePath,
    this.totalPerson,
    this.entryGate,
    this.entryPlace,
  });

  factory TVisitorList.fromJson(Map<String, dynamic> json) => TVisitorList(
    id: json["id"],
    badgeNumber: json["badgeNumber"],
    name: json["name"],
    email: json["email"],
    mobileNumber: json["mobileNumber"],
    companyName: json["companyName"],
    vehicleNumber: json["vehicleNumber"],
    vehicleType: json["vehicleType"],
    numberOfItems: json["numberOfItems"],
    itemTypes: json["itemTypes"],
    identityProofImage: json["identityProofImage"],
    host: json["host"],
    department: json["department"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    time: json["time"],
    createdBy: json["createdBy"],
    createdAt: json["createdAt"],
    updatedBy: json["updatedBy"],
    updatedAt: json["updatedAt"],
    approvedBy: json["approvedBy"],
    approvedAt: json["approvedAt"],
    duration: json["duration"],
    rejectedBy: json["rejectedBy"],
    rejectedAt: json["rejectedAt"],
    checkoutBy: json["checkoutBy"],
    checkoutAt: json["checkoutAt"],
    checkoutImage: json["checkoutImage"],
    appointmentStatus: json["appointmentStatus"],
    imagePath: json["imagePath"],
    totalPerson: json["totalPerson"],
    entryGate: json["entryGate"],
    entryPlace: json["entryPlace"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "badgeNumber": badgeNumber,
    "name": name,
    "email": email,
    "mobileNumber": mobileNumber,
    "companyName": companyName,
    "vehicleNumber": vehicleNumber,
    "vehicleType": vehicleType,
    "numberOfItems": numberOfItems,
    "itemTypes": itemTypes,
    "identityProofImage": identityProofImage,
    "host": host,
    "department": department,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "time": time,
    "createdBy": createdBy,
    "createdAt": createdAt,
    "updatedBy": updatedBy,
    "updatedAt": updatedAt,
    "approvedBy": approvedBy,
    "approvedAt": approvedAt,
    "duration": duration,
    "rejectedBy": rejectedBy,
    "rejectedAt": rejectedAt,
    "checkoutBy": checkoutBy,
    "checkoutAt": checkoutAt,
    "checkoutImage": checkoutImage,
    "appointmentStatus": appointmentStatus,
    "imagePath": imagePath,
    "totalPerson": totalPerson,
    "entryGate": entryGate,
    "entryPlace": entryPlace,
  };
}
