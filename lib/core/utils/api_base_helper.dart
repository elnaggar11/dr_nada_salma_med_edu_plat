import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/end_point.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/exceptions.dart';
import 'package:flutter/cupertino.dart';
import '../../injection_container/injection_container.dart';
import '../local/auth_local_data_source.dart';

class ApiBaseHelper {
  Dio dio = Dio();
  Map<String, String> headers = {"Accept": "application/json"};
  Options options = Options(
    validateStatus: (_) => true,
    contentType: Headers.jsonContentType,
    responseType: ResponseType.json,
  );

  void updateLocalHeader(String locale) {
    headers["Accept-Language"] = locale;
    dio.options.headers = headers;
  }

  void updateAuthToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void dioInit() {
    dio = Dio();
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = const Duration(milliseconds: 25000);
    dio.options.sendTimeout = const Duration(milliseconds: 25000);
    dio.options.receiveTimeout = const Duration(milliseconds: 25000);
    dio.options.headers = headers;
    dio.options.validateStatus = (_) => true;
    dio.options.contentType = Headers.jsonContentType;
    dio.options.responseType = ResponseType.json;
    dio.interceptors.add(AuthInterceptor());
    dio.interceptors.add(PrettyApiLogger());
  }

  Future<dynamic> post({
    required String url,
    required Map<String, dynamic> body,
    String? token,
  }) async {
    FormData formData = FormData.fromMap(body);
    try {
      Response response = await dio.post(url, data: formData, options: options);
      return _returnResponseJson(response);
    } on DioException catch (e) {
      throw ServerException(message: _extractErrorMessage(e.response?.data));
    } on SocketException {
      throw ServerException(message: "No internet, please try again later");
    } on IOException catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<dynamic> postJson({
    required String url,
    required Map<String, dynamic> body,
    String? token,
  }) async {
    try {
      Response response = await dio.post(url, data: body, options: options);
      return _returnResponseJson(response);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response != null && e.response!.data != null
            ? (e.response!.data["error"] ??
                      e.response!.data["message"] ??
                      "Something went wrong")
                  .toString()
            : "Something went wrong",
      );
    } on SocketException {
      throw ServerException(message: "No internet, please try again later");
    } on IOException catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<dynamic> putJson({
    required String url,
    required Map<String, dynamic> body,
    String? token,
  }) async {
    try {
      Response response = await dio.put(url, data: body, options: options);
      return _returnResponseJson(response);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response != null && e.response!.data != null
            ? (e.response!.data["error"] ??
                      e.response!.data["message"] ??
                      "Something went wrong")
                  .toString()
            : "Something went wrong",
      );
    } on SocketException {
      throw ServerException(message: "No internet, please try again later");
    } on IOException catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<dynamic> get({
    required String url,
    String? token,
    Map<String, dynamic>? query,
  }) async {
    try {
      Response response = await dio.get(
        url,
        queryParameters: query,
        options: options,
      );
      return _returnResponseJson(response);
    } on DioException catch (e) {
      throw ServerException(message: _extractErrorMessage(e.response?.data));
    } on SocketException {
      throw ServerException(message: "No internet, please try again later");
    }
  }

  Future<dynamic> delete({required String url, String? token}) async {
    try {
      debugPrint("url => $url");
      final Response response = await dio.delete(url, options: options);

      return _returnResponseJson(response);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response != null
            ? e.response!.data["msg"] ?? "Something Went Wrong"
            : " Something went wrong",
      );
    } on SocketException {
      throw ServerException(message: "No internet please try again later");
    }
  }

  dynamic _returnResponseJson(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 201:
        return response.data;
      case 400:
        throw ServerException(message: _extractErrorMessage(response.data));
      case 422:
        throw UnprocessableContentException(
          message: _extractErrorMessage(response.data),
        );
      case 401:
        throw UnAuthorizedException(
          message: _extractErrorMessage(response.data),
        );
      case 403:
        throw ForbiddenException(
          message: _extractErrorMessage(response.data),
          key: _extractKey(response.data),
        );
      case 404:
        throw NotFoundException(message: _extractErrorMessage(response.data));
      case 409:
        throw ForbiddenException(
          message: _extractErrorMessage(response.data),
          key: _extractKey(response.data),
        );
      case 500:
        throw ServerException(
          message:
              'Error occurred while Communication with Server with StatusCode :'
              ' ${response.statusCode} ${response.data}',
        );
      default:
        debugPrint(
          "Error occurred while Communication with Server with StatusCode : "
          "${response.statusCode} ${response.data}",
        );
        throw ServerException(
          message:
              "Error occurred while Communication with Server with StatusCode : "
              "${response.statusCode} ${response.data}",
        );
    }
  }

  String _extractErrorMessage(dynamic data) {
    if (data is Map) {
      final message = data["error"] ?? data["message"] ?? data["msg"];
      if (message != null && message.toString().trim().isNotEmpty) {
        return message.toString();
      }
    }

    if (data != null && data.toString().trim().isNotEmpty) {
      return data.toString();
    }

    return "Something went wrong";
  }

  String? _extractKey(dynamic data) {
    if (data is Map) {
      return data["key"]?.toString();
    }
    return null;
  }
}

class AuthInterceptor extends Interceptor {
  AuthInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = sharedPreferences.get(cacheTokenConst);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    } else {
      options.cancelToken;
    }
    super.onRequest(options, handler);
  }
}

class PrettyApiLogger extends Interceptor {
  static const _jsonEncoder = JsonEncoder.withIndent("  ");
  static const _startedAtKey = "pretty_logger_started_at";

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra[_startedAtKey] = DateTime.now().millisecondsSinceEpoch;
    _printBlock("API REQUEST", [
      "${options.method} ${options.uri}",
      "Headers: ${_prettyJson(_safeHeaders(options.headers))}",
      if (options.queryParameters.isNotEmpty)
        "Query: ${_prettyJson(options.queryParameters)}",
      if (options.data != null) "Body: ${_prettyJson(_safeBody(options.data))}",
    ]);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _printBlock("API RESPONSE", [
      "${response.requestOptions.method} ${response.requestOptions.uri}",
      "Status: ${response.statusCode}",
      "Duration: ${_duration(response.requestOptions)}",
      "Data: ${_prettyJson(response.data)}",
    ]);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _printBlock("API ERROR", [
      "${err.requestOptions.method} ${err.requestOptions.uri}",
      "Status: ${err.response?.statusCode ?? "No response"}",
      "Duration: ${_duration(err.requestOptions)}",
      "Message: ${err.message}",
      if (err.response?.data != null)
        "Data: ${_prettyJson(err.response?.data)}",
    ]);
    super.onError(err, handler);
  }

  static Map<String, dynamic> _safeHeaders(Map<String, dynamic> headers) {
    return headers.map((key, value) {
      if (key.toLowerCase() == "authorization") {
        return MapEntry(key, _maskToken(value?.toString()));
      }
      return MapEntry(key, value);
    });
  }

  static dynamic _safeBody(dynamic body) {
    if (body is FormData) {
      return {
        "fields": {for (final field in body.fields) field.key: field.value},
        "files": body.files
            .map(
              (file) => {
                "field": file.key,
                "filename": file.value.filename,
                "contentType": file.value.contentType.toString(),
                "length": file.value.length,
              },
            )
            .toList(),
      };
    }
    return body;
  }

  static String _prettyJson(dynamic value) {
    try {
      return _jsonEncoder.convert(value);
    } catch (_) {
      return value.toString();
    }
  }

  static String _duration(RequestOptions options) {
    final startedAt = options.extra[_startedAtKey];
    if (startedAt is! int) return "-";

    final milliseconds = DateTime.now().millisecondsSinceEpoch - startedAt;
    return "${milliseconds}ms";
  }

  static String _maskToken(String? value) {
    if (value == null || value.isEmpty) return "";
    final parts = value.split(" ");
    final token = parts.length > 1 ? parts.last : value;
    if (token.length <= 12) return "${parts.first} ***";

    final maskedToken =
        "${token.substring(0, 6)}...${token.substring(token.length - 4)}";
    return parts.length > 1 ? "${parts.first} $maskedToken" : maskedToken;
  }

  static void _printBlock(String title, List<String> lines) {
    debugPrint("+---------------- $title ----------------");
    for (final line in lines) {
      for (final chunk in _chunks(line)) {
        debugPrint("| $chunk");
      }
    }
    debugPrint("+----------------------------------------");
  }

  static Iterable<String> _chunks(String value) sync* {
    const chunkSize = 900;
    for (var index = 0; index < value.length; index += chunkSize) {
      final end = index + chunkSize;
      yield value.substring(index, end > value.length ? value.length : end);
    }
  }
}
