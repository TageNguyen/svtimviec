import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:student_job_applying/src/models/province.dart';

class ProvinceApi {
  final String _url =
      'https://online-gateway.ghn.vn/shiip/public-api/master-data/province';
  final String _token = 'd0393187-b68e-11ec-935b-4e3cff801388';

  /// get Vietnamese provinces data
  Future<dynamic> _getProvincesJsonData() async {
    try {
      Map<String, String> headers = <String, String>{};
      headers.addAll({'token': _token});
      Uri uri = Uri.parse(_url);
      http.Response response = await http.get(uri, headers: headers);
      int statusCode = response.statusCode;
      if (200 >= statusCode && statusCode <= 299) {
        return jsonDecode(utf8.decode(response.bodyBytes));
      }
      if (400 <= statusCode && statusCode <= 499) {
        throw Exception(jsonDecode(utf8.decode(response.bodyBytes))['message']);
      } else if (500 <= response.statusCode && response.statusCode <= 599) {
        throw Exception('Server Error');
      }
      throw Exception('Unhandled error');
    } on SocketException catch (_) {
      throw Exception('Connection error');
    }
  }

  /// get Vietnamese provinces
  Future<List<Province>> getListProvinces() {
    return _getProvincesJsonData().then((res) =>
        res['data'].map<Province>((e) => Province.fromJson(e)).toList());
  }
}
