import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:student_job_applying/src/managers/user_manager.dart';
import 'package:student_job_applying/src/struct/api/api_util/api_url.dart';

class BaseApi {
  BaseApi() {
    domain = ApiUrl.domain;
  }

  late String _domain;

  set domain(String newDomain) => _domain = newDomain;

  Future<dynamic> getMethod(url,
      {Map<String, String>? headers, Map<String, dynamic>? param}) async {
    try {
      headers ??= <String, String>{};
      headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${UserManager.globalToken}'
      });
      _logRequest(url, 'GET', param, {}, headers);
      Uri uri = Uri.parse('$_domain$url').replace(queryParameters: param);
      http.Response response = await http.get(uri, headers: headers);
      int statusCode = response.statusCode;
      _logResponse(
          url, statusCode, jsonDecode(utf8.decode(response.bodyBytes)));
      return _handleResponse(
          statusCode, jsonDecode(utf8.decode(response.bodyBytes)));
    } on SocketException catch (_) {
      throw Exception('Connection error');
    }
  }

  Future<dynamic> postMethod(url,
      {param,
      Map<String, dynamic>? body,
      Map<String, String>? headers,
      noJsonEncode = false}) async {
    try {
      headers ??= <String, String>{};
      body ??= <String, dynamic>{};
      Map<String, File> fileMap = {};
      Map<String, String> _body = {};

      headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${UserManager.globalToken}'
      });

      body.removeWhere(
        (key, value) {
          if (value is File) {
            fileMap.addAll({key: value});
            return true;
          }
          return false;
        },
      );

      body.forEach((key, value) => _body[key] = '$value');

      _logRequest(url, 'POST', param, body, headers);

      Uri uri = Uri.parse('$_domain$url').replace(queryParameters: param);
      var request = http.MultipartRequest('POST', uri);

      request.headers.addAll(headers);
      request.fields.addAll(_body);
      if (fileMap.isNotEmpty) {
        fileMap.forEach((key, value) async {
          request.files.add(
            await http.MultipartFile.fromPath(
              key,
              value.path,
            ),
          );
        });
      }
      var response = await request.send();
      String responseBody = await response.stream.bytesToString();

      // http.Response response =
      //     await http.post(uri, headers: headers, body: body);
      int statusCode = response.statusCode;
      _logResponse(url, statusCode, jsonDecode(responseBody));
      return _handleResponse(statusCode, jsonDecode(responseBody));
    } on SocketException catch (_) {
      throw Exception('Connection error');
    }
  }

  Future<dynamic> putMethod(url,
      {param, body, Map<String, String>? headers, noJsonEncode = false}) async {
    try {
      headers ??= <String, String>{};

      headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${UserManager.globalToken}'
      });

      if (noJsonEncode) {
        body = body;
      } else {
        body = json.encoder.convert(body);
      }

      _logRequest(url, 'PUT', param, body, headers);
      Uri uri = Uri.parse('$_domain$url').replace(queryParameters: param);
      http.Response response =
          await http.put(uri, headers: headers, body: body);
      int statusCode = response.statusCode;
      _logResponse(
          url, statusCode, jsonDecode(utf8.decode(response.bodyBytes)));
      return _handleResponse(
          statusCode, jsonDecode(utf8.decode(response.bodyBytes)));
    } on SocketException catch (_) {
      throw Exception('Connection error');
    }
  }

  Future<dynamic> deleteMethod(url,
      {param, body, Map<String, String>? headers, noJsonEncode = false}) async {
    try {
      headers ??= <String, String>{};

      headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${UserManager.globalToken}'
      });

      if (noJsonEncode) {
        body = body;
      } else {
        body = json.encoder.convert(body);
      }

      _logRequest(url, 'DELETE', param, body, headers);
      Uri uri = Uri.parse('$_domain$url').replace(queryParameters: param);
      http.Response response =
          await http.delete(uri, headers: headers, body: body);
      int statusCode = response.statusCode;
      _logResponse(
          url, statusCode, jsonDecode(utf8.decode(response.bodyBytes)));
      return _handleResponse(
          statusCode, jsonDecode(utf8.decode(response.bodyBytes)));
    } on SocketException catch (_) {
      throw Exception('Connection error');
    }
  }

  dynamic _handleResponse(int statusCode, responseBody) {
    if (200 >= statusCode && statusCode <= 299) {
      return responseBody;
    }
    if (statusCode == 401 || statusCode == 403) {
      throw Exception('Token expired');
    }
    if (400 <= statusCode && statusCode <= 499) {
      throw Exception(responseBody['message']);
    } else if (500 <= statusCode && statusCode <= 599) {
      throw Exception('Server Error');
    }
    throw Exception('Unhandled error');
  }

  void _logRequest(String url, String method, dynamic param, dynamic body,
      Map<String, String> headers) {
    debugPrint(
        '====================================================================================');
    debugPrint('[${method.toUpperCase()}]');
    debugPrint('REQUEST TO API: $_domain$url With: ');
    debugPrint('HEADER: ' + headers.toString() + '\n');
    debugPrint('PARAMS: ' + param.toString() + '\n');
    debugPrint('BODY: ' + body.toString() + '\n');
    debugPrint(
        '====================================================================================');
  }

  void _logResponse(String url, int statusCode, dynamic body) {
    debugPrint(
        '====================================================================================');
    debugPrint('RESPONSE API: $_domain$url With:');
    debugPrint('STATUS CODE: $statusCode');
    debugPrint('BODY: $body ');
    debugPrint(
        '====================================================================================');
  }
}
