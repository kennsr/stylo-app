import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_constants.dart';
import '../constants/app_constants.dart';
import '../constants/env_config.dart';
import '../errors/exceptions.dart';
import 'mock_api_data.dart';

class ApiClient {
  final http.Client httpClient;
  final SharedPreferences prefs;

  ApiClient({required this.httpClient, required this.prefs});

  Map<String, String> get _headers {
    // Try new session token first, then fall back to legacy token
    final token =
        prefs.getString('stylo_session_token') ??
        prefs.getString(AppConstants.tokenKey);
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  Uri _buildUri(String path, [Map<String, String>? queryParams]) {
    final base = Uri.parse(ApiConstants.baseUrl);
    return Uri(
      scheme: base.scheme,
      host: base.host,
      port: base.port, // ← preserve port (e.g. 8080 for localhost)
      path: base.path + path,
      queryParameters: queryParams,
    );
  }

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, String>? queryParams,
  }) async {
    if (EnvConfig.useMock) {
      await Future.delayed(const Duration(milliseconds: 500));
      return MockApiData.getMockResponse(
        path,
        method: 'GET',
        queryParams: queryParams,
      );
    }
    try {
      final response = await httpClient
          .get(_buildUri(path, queryParams), headers: _headers)
          .timeout(ApiConstants.receiveTimeout);
      return _handleResponse(response);
    } on ServerException {
      rethrow;
    } on AuthException {
      rethrow;
    } catch (e) {
      throw NetworkException(message: e.toString());
    }
  }

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    if (EnvConfig.useMock) {
      await Future.delayed(const Duration(milliseconds: 500));
      return MockApiData.getMockResponse(path, method: 'POST');
    }
    try {
      final response = await httpClient
          .post(
            _buildUri(path),
            headers: _headers,
            body: jsonEncode(body ?? {}),
          )
          .timeout(ApiConstants.receiveTimeout);
      return _handleResponse(response);
    } on ServerException {
      rethrow;
    } on AuthException {
      rethrow;
    } catch (e) {
      throw NetworkException(message: e.toString());
    }
  }

  Future<Map<String, dynamic>> put(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    if (EnvConfig.useMock) {
      await Future.delayed(const Duration(milliseconds: 500));
      return MockApiData.getMockResponse(path, method: 'PUT');
    }
    try {
      final response = await httpClient
          .put(_buildUri(path), headers: _headers, body: jsonEncode(body ?? {}))
          .timeout(ApiConstants.receiveTimeout);
      return _handleResponse(response);
    } on ServerException {
      rethrow;
    } on AuthException {
      rethrow;
    } catch (e) {
      throw NetworkException(message: e.toString());
    }
  }

  Future<Map<String, dynamic>> patch(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    if (EnvConfig.useMock) {
      await Future.delayed(const Duration(milliseconds: 500));
      return MockApiData.getMockResponse(path, method: 'PATCH');
    }
    try {
      final response = await httpClient
          .patch(
            _buildUri(path),
            headers: _headers,
            body: jsonEncode(body ?? {}),
          )
          .timeout(ApiConstants.receiveTimeout);
      return _handleResponse(response);
    } on ServerException {
      rethrow;
    } on AuthException {
      rethrow;
    } catch (e) {
      throw NetworkException(message: e.toString());
    }
  }

  Future<Map<String, dynamic>> delete(String path) async {
    if (EnvConfig.useMock) {
      await Future.delayed(const Duration(milliseconds: 500));
      return MockApiData.getMockResponse(path, method: 'DELETE');
    }
    try {
      final response = await httpClient
          .delete(_buildUri(path), headers: _headers)
          .timeout(ApiConstants.receiveTimeout);
      return _handleResponse(response);
    } on ServerException {
      rethrow;
    } on AuthException {
      rethrow;
    } catch (e) {
      throw NetworkException(message: e.toString());
    }
  }

  Future<Map<String, dynamic>> uploadMultipart(
    String path, {
    required List<MultipartFile> files,
    Map<String, String>? fields,
  }) async {
    if (EnvConfig.useMock) {
      await Future.delayed(const Duration(milliseconds: 800));
      return MockApiData.getMockResponse(path, method: 'POST');
    }
    try {
      final request = http.MultipartRequest(
        'POST',
        _buildUri(path),
      );
      request.headers.addAll(_headers);
      request.files.addAll(files);
      fields?.forEach((key, value) => request.fields[key] = value);
      
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      return _handleResponse(response);
    } on ServerException {
      rethrow;
    } on AuthException {
      rethrow;
    } catch (e) {
      throw NetworkException(message: e.toString());
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    } else if (response.statusCode == 401) {
      throw AuthException(message: 'Sesi habis, silakan login kembali');
    } else {
      throw ServerException(
        message: body['message'] as String? ?? 'Terjadi kesalahan pada server',
        statusCode: response.statusCode,
      );
    }
  }
}
