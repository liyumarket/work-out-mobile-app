import 'package:dio/dio.dart';

class DioService {
  final Dio _dio = Dio();

  Future<Response> getRequest(String url, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> postRequest(String url, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(url, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> putRequest(String url, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.put(url, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> deleteRequest(String url, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.delete(url, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Response _handleResponse(Response response) {
    if (response.statusCode == 200) {
      return response;
    }else  if (response.statusCode == 201) {
      return response;
    } else if (response.statusCode == 400) {
      final data = response.data;
      if (data != null) {
        throw Exception(data['message']);
      } else {
        throw Exception(response.statusMessage);
      }
    } else {
      throw Exception('Request failed: ${response.statusMessage}');
    }
  }

   _handleDioError(DioException e) {
    if (e.response != null) {
      return _handleResponse(e.response!);
    } else {
      return Exception('Network error: ${e.message}');
    }
  }
}
