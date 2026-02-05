// To parse this JSON data, do
//
//     final visitorModel = visitorModelFromJson(jsonString);

import 'dart:convert';

VisitorModel visitorModelFromJson(String str) => VisitorModel.fromJson(json.decode(str));

String visitorModelToJson(VisitorModel data) => json.encode(data.toJson());

class VisitorModel {
  List<VisitorList>? activeVisitorList;
  List<VisitorList>? pendingVisitorList;
  List<VisitorList>? historyVisitorList;
  int? status;

  VisitorModel({
    this.activeVisitorList,
    this.pendingVisitorList,
    this.historyVisitorList,
    this.status,
  });

  factory VisitorModel.fromJson(Map<String, dynamic> json) => VisitorModel(
    activeVisitorList: json["active_visitor_list"] == null ? [] : List<VisitorList>.from(json["active_visitor_list"]!.map((x) => VisitorList.fromJson(x))),
    pendingVisitorList: json["pending_visitor_list"] == null ? [] : List<VisitorList>.from(json["pending_visitor_list"]!.map((x) => VisitorList.fromJson(x))),
    historyVisitorList: json["history_visitor_list"] == null ? [] : List<VisitorList>.from(json["history_visitor_list"]!.map((x) => VisitorList.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "active_visitor_list": activeVisitorList == null ? [] : List<dynamic>.from(activeVisitorList!.map((x) => x.toJson())),
    "pending_visitor_list": pendingVisitorList == null ? [] : List<dynamic>.from(pendingVisitorList!.map((x) => x.toJson())),
    "history_visitor_list": historyVisitorList == null ? [] : List<dynamic>.from(historyVisitorList!.map((x) => x.toJson())),
    "status": status,
  };
}

class VisitorList {
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

  VisitorList({
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

  factory VisitorList.fromJson(Map<String, dynamic> json) => VisitorList(
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
