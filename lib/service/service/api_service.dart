import 'dart:convert';
import 'package:flashcards/const/const.dart';
import 'package:flashcards/service/category.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class APIService {
  static final _service = APIService.internal();

  factory APIService() => _service;

  APIService.internal();

   Future request({
    Method method = Method.get,
    required String path,
    Map<String, dynamic>? body,
  }) async {
    final uri = Uri.parse(baseUrl + path);
    http.Response response;

    switch (method) {
      case Method.get:
        response = await http.get(
          uri,
        );
        break;
      case Method.put:
        response = await http.put(
          uri,
          body: body,
          encoding: utf8,
        );
        break;
      case Method.delete:
        response = await http.delete(
          uri,
          body: body,
          encoding: utf8,
        );
        break;
      default:
        response = await http.post(
          uri,
          body: body,
          encoding: utf8,
        );
        break;
    }
    final json = jsonDecode(response.body);
    return json;
  }
}
final apiService = APIService();

enum Method {
  get,
  post,
  put,
  delete,
}
