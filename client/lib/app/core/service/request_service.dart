import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kronos/app/core/interface/irequest_service.dart';
import 'package:kronos/app/core/model/response_model.dart';

class RequestService implements IRequestService {
  @override
  Future<ResponseModel> get(String endpoint) async {
    return await _sendRequest(
      () => http.get(Uri.parse(endpoint), headers: _headersDefault()),
    );
  }

  @override
  Future<ResponseModel> post(String endpoint, dynamic body) async {
    return await _sendRequest(
      () => http.post(
        Uri.parse(endpoint),
        headers: _headersDefault(),
        body: jsonEncode(body),
      ),
    );
  }

  @override
  Future<ResponseModel> patch(String endpoint, dynamic body) async {
    return await _sendRequest(
      () => http.patch(
        Uri.parse(endpoint),
        headers: _headersDefault(),
        body: jsonEncode(body),
      ),
    );
  }

  @override
  Future<ResponseModel> delete(String endpoint) async {
    return await _sendRequest(
      () => http.delete(Uri.parse(endpoint), headers: _headersDefault()),
    );
  }

  Future<ResponseModel> _sendRequest(
    Future<http.Response> Function() request,
  ) async {
    var response = await request();
    return ResponseModel(
      statusCode: response.statusCode,
      body: _convertBody(response),
    );
  }

  Map<String, String> _headersDefault() {
    var headers = {'Content-Type': 'application/json; charset=UTF-8'};
    return headers;
  }

  String _convertBody(http.Response response) {
    if (response.body.isEmpty) {
      return '';
    }
    return response.body;
  }
}
