// To parse this JSON data, do
//
//     final searchSiteModel = searchSiteModelFromJson(jsonString);

import 'dart:convert';

SearchSiteModel searchSiteModelFromJson(String str) => SearchSiteModel.fromJson(json.decode(str));

String searchSiteModelToJson(SearchSiteModel data) => json.encode(data.toJson());

class SearchSiteModel {
  int? status;
  List<String>? siteNameList;

  SearchSiteModel({
    this.status,
    this.siteNameList,
  });

  factory SearchSiteModel.fromJson(Map<String, dynamic> json) => SearchSiteModel(
    status: json["status"],
    siteNameList: json["site_name_list"] == null ? [] : List<String>.from(json["site_name_list"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "site_name_list": siteNameList == null ? [] : List<dynamic>.from(siteNameList!.map((x) => x)),
  };
}
