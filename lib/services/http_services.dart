import 'dart:convert';
import 'dart:developer';
import 'dart:io' show File;

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:visitor_app/constant/endpoint_constant.dart' show ApiEndPoint;
import 'package:visitor_app/constant/local_storage_services.dart' show LocalStorageServices;
import 'package:visitor_app/constant/storage_key_constant.dart' show LocalStorageKey;
import 'package:visitor_app/widget/custom_loading_dialog.dart';

class HttpServices {
  static String endPointUrl = ApiEndPoint.baseUrl;

  static Future<Map<String, String>> getHeaders() async {
    String? token = await LocalStorageServices.getDataFromLocalStorage(
        dataType: LocalStorageKey.stringType, prefKey: LocalStorageKey.token);
    bool? isLogin = await LocalStorageServices.getDataFromLocalStorage(
        dataType: LocalStorageKey.boolType, prefKey: LocalStorageKey.isLogin);
    log("My Token ::: $token");
    log("My isLogin ::: $isLogin");
    // if (isLogin == null && token == null) {
    //   log("hello token:---11111");
    //   return {
    //     'Content-type': 'application/x-www-form-urlencoded',
    //     'Accept': 'application/json',
    //     'Authorization': "",
    //   };
    // }

    if (token != null) {
      log("hello token:---2222");

      return {'Content-type': 'application/json', 'Accept': 'application/json', 'Authorization': "Bearer $token"};
    } else {
      log("hello token:---33333");

      return {'Content-type': 'application/x-www-form-urlencoded', 'Accept': 'application/json'};
    }
  }

  static Future<Map<String, dynamic>> getHttpMethod({header, required String? url}) async {
    var header = await getHeaders();
    log("Get Http Method Url ::: '$endPointUrl$url'");
    log("Get Http Method Headers ::: '$header'");
    http.Response response = await http.get(Uri.parse("$endPointUrl$url"), headers: header);
    log("Get Http Method's Status Code ::: '${response.statusCode}'");
    log("Get Http Response Body ::: '${response.body}'");
    if (response.statusCode == 200 || response.statusCode == 201) {
      log("In Get '${response.statusCode}'");
      Map<String, dynamic> data = {'body': response.body, 'headers': response.headers, 'error_description': null};
      return data;
    } else {
      log("Get Http Method's Failed Status Code ::: ${response.statusCode}'");
      return {'body': response.body, 'headers': response.headers, 'error_description': "${response.statusCode}"};
    }
  }

  static Future<Map<String, dynamic>> postHttpMethod(
      {required String? url, Map<String, dynamic>? data, bool isHeaderPassWithToken = true}) async {
    var header = isHeaderPassWithToken == true
        ? await getHeaders()
        : {'Content-type': 'application/json', 'Accept': 'application/json'};
    log("Post Http Method Url ::: $endPointUrl$url");
    log("Post Http Method Payload Data ::: $data");
    log("Post Http Method Headers ::: '$header'");
    http.Response response =
        await http.post(Uri.parse("$endPointUrl$url"), headers: header, body: data == null ? null : jsonEncode(data));
    log("Post Http Method Status Code ::: ${response.statusCode}");
    log("Post Http Method Response Body ::: ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return {'body': response.body, 'headers': response.headers, 'error_description': null};
    } else {
      log("Post Http Method's Failed Status Code ::: ${response.statusCode}'");
      return {'body': response.body, 'headers': response.headers, 'error_description': "${response.statusCode}"};
    }
  }

  /// Common POST method
  static Future<Map<String, dynamic>> postFormUrlEncoded({
    required String url,
    required Map<String, String> body,
    Map<String, String>? headers,
  }) async {
    try {
      final finalHeaders = headers ??
          {
            'Accept': 'application/json',
            'Content-Type': 'application/x-www-form-urlencoded',
          };

      log("POST URL ::: $url");
      log("POST BODY ::: $body");
      log("POST HEADERS ::: $finalHeaders");

      final request = http.Request(
        'POST',
        Uri.parse(endPointUrl+url),
      );

      request.bodyFields = body;
      request.headers.addAll(finalHeaders);

      final streamedResponse = await request.send();
      final responseBody = await streamedResponse.stream.bytesToString();

      log("STATUS CODE ::: ${streamedResponse.statusCode}");
      log("RESPONSE BODY ::: $responseBody");

      if (streamedResponse.statusCode == 200 ||
          streamedResponse.statusCode == 201) {
        return {
          'body': responseBody,
          'headers': streamedResponse.headers,
          'error_description': null,
        };
      } else {
        return {
          'body': responseBody,
          'headers': streamedResponse.headers,
          'error_description':
          streamedResponse.statusCode.toString(),
        };
      }
    } catch (e, st) {
      log("FORM POST ERROR ::: $e");
      log("STACKTRACE ::: $st");
      return {
        'body': null,
        'headers': null,
        'error_description': e.toString(),
      };
    }
  }

  static Future<Map<String, dynamic>> putHttpMethod(
      {@required String? url, Map<String, dynamic>? data, Map<String, String>? customHeader}) async {
    var header = customHeader ?? await getHeaders();
    log("Put Http Method Url ::: $endPointUrl$url");
    log("Put Http Method Payload Data ::: $data");
    log("Put Http Method Headers ::: $header");
    http.Response response =
        await http.put(Uri.parse("$endPointUrl$url"), headers: header, body: data == null ? null : jsonEncode(data));
    log("Put Http Method Status Code ::: ${response.statusCode}");
    log("Put Http Method Response Body ::: ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      log("In Put '${response.statusCode}'");
      Map<String, dynamic> data = {'body': response.body, 'headers': response.headers, 'error_description': null};
      return data;
    } else {
      log("Put Http Method's Failed Status Code ::: ${response.statusCode}'");
      return {'body': response.body, 'headers': response.headers, 'error_description': "${response.statusCode}"};
    }
  }

  static Future<Map<String, dynamic>> deleteHttpMethod({@required String? url, Map<String, dynamic>? data}) async {
    var header = await getHeaders();
    log("Delete Http Method Uel ::: $endPointUrl$url");
    log("Delete Http Method Payload data ::: $data");
    log("Delete Http Method Headers ::: $header");
    http.Response response =
        await http.delete(Uri.parse("$endPointUrl$url"), headers: header, body: data == null ? null : jsonEncode(data));
    log("Delete Http Method's Response Body ::: ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> data = {'body': response.body, 'headers': response.headers, 'error_description': null};
      return data;
    } else {
      log("Delete Http Method Failed Status Code ::: ${response.statusCode}'");
      return {'body': response.body, 'headers': response.headers, 'error_description': "${response.statusCode}"};
    }
  }

  static Future<Map<String, dynamic>> formHttpMethod(
      {required String? url,
      Map<String, String>? data,
      File? singleFile,
      String? singleFileKey,
      List<File>? multipleFile,
      String? multipleFileKey}) async {
    var header = await getHeaders();
    log("Form Http Method Url ::: $endPointUrl$url");
    log("Form Http Method Headers ::: $header");
    http.MultipartRequest request = http.MultipartRequest("POST", Uri.parse("$endPointUrl$url"));
    request.headers.addAll(header);
    if (data != null) {
      request.fields.addAll(data);
    }
    if (singleFile != null) {
      request.files.add(await http.MultipartFile.fromPath(singleFileKey!, singleFile.path));
    }
    if ((multipleFile ?? []).isNotEmpty) {
      for (File element in (multipleFile ?? [])) {
        request.files.add(await http.MultipartFile.fromPath(multipleFileKey!, element.path));
      }
    }
    log("Form Http Method Field ::: ${request.fields} \nFord Http Method File ::: ${request.files}");
    http.StreamedResponse streamedResponse = await request.send();
    if (streamedResponse.statusCode == 200 || streamedResponse.statusCode == 201) {
      http.Response response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Form Http Method Response Body ::: ${response.body}");
        Map<String, dynamic> data;
        data = {'body': response.body, 'headers': response.headers, 'error_description': null};
        return data;
      } else {
        debugPrint("Form Http Method's Failed Status Code ::: ${response.statusCode}'");
        return {'body': response.body, 'headers': response.headers, 'error_description': "${response.statusCode}"};
      }
    } else {
      debugPrint("Form Http Method's Failed Status Code ::: ${streamedResponse.statusCode}'");
      return {'headers': streamedResponse.headers, 'error_description': "${streamedResponse.statusCode}"};
    }
  }
}
