// To parse this JSON data, do
//
//     final visitorDataOnMObileModel = visitorDataOnMObileModelFromJson(jsonString);

import 'dart:convert';

VisitorDataOnMObileModel visitorDataOnMObileModelFromJson(String str) => VisitorDataOnMObileModel.fromJson(json.decode(str));

String visitorDataOnMObileModelToJson(VisitorDataOnMObileModel data) => json.encode(data.toJson());

class VisitorDataOnMObileModel {
  int? status;
  VisitorData? visitorData;

  VisitorDataOnMObileModel({
    this.status,
    this.visitorData,
  });

  factory VisitorDataOnMObileModel.fromJson(Map<String, dynamic> json) => VisitorDataOnMObileModel(
    status: json["status"],
    visitorData: json["visitor_data"] == null ? null : VisitorData.fromJson(json["visitor_data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "visitor_data": visitorData?.toJson(),
  };
}

class VisitorData {
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
  dynamic duration;
  dynamic rejectedBy;
  dynamic rejectedAt;
  dynamic checkoutBy;
  dynamic checkoutAt;
  dynamic checkoutImage;
  String? appointmentStatus;
  String? imagePath;
  int? totalPerson;
  String? entryGate;
  String? entryPlace;

  VisitorData({
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

  factory VisitorData.fromJson(Map<String, dynamic> json) => VisitorData(
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
