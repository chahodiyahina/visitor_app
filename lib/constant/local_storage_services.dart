import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageServices {
  static late SharedPreferences sharedPreferences;

  static Future initializeSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static setDataToLocalStorage({
    String? dataType,
    String? prefKey,
    bool? boolData,
    double? doubleData,
    int? integerData,
    String? stringData,
    List<String>? listOfStringData,
  }) async {
    switch (dataType) {
      case "bool":
        return sharedPreferences.setBool(prefKey!, boolData!);
      case "double":
        return sharedPreferences.setDouble(prefKey!, doubleData!);
      case "integer":
        return sharedPreferences.setInt(prefKey!, integerData!);
      case "stringType":
        return sharedPreferences.setString(prefKey!, stringData!);
      case "listOfString":
        return sharedPreferences.setStringList(prefKey!, listOfStringData!);
      default:
        return "Something went wrong during setting data to local storage";
    }
  }

  static getDataFromLocalStorage({String? dataType, String? prefKey}) async {
    switch (dataType) {
      case "bool":
        return sharedPreferences.getBool(prefKey!);
      case "double":
        return sharedPreferences.getDouble(prefKey!);
      case "integer":
        return sharedPreferences.getInt(prefKey!);
      case "stringType":
        return sharedPreferences.getString(prefKey!);
      case "listOfString":
        return sharedPreferences.getStringList(prefKey!);
      default:
        return "Something went wrong during getting data from local storage";
    }
  }

  static clearLocalStorage() async {
    sharedPreferences.clear();
  }

  static Future<void> clearDataFromLocalStorage({required String prefKey}) async {
    if (sharedPreferences.containsKey(prefKey)) {
      await sharedPreferences.remove(prefKey);
      log("Storage key '$prefKey' has been cleared.");
    } else {
      log("Key '$prefKey' does not exist.");
    }
  }
}
