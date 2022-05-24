import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:pokeapp/helper/http_response.dart';

class Http {
  late Dio _dio;
  late bool _logsEnabled;
  final Logger _logs = Logger();

  Http({
    required Dio dio,
    required bool logsEnabled,
  }) {
    _dio = dio;
    _logsEnabled = logsEnabled;
  }

  Future<HttpResponse<T>> request<T>(
    String path, {
    String method = "GET",
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? formData,
    Map<String, String>? headers,
    T Function(dynamic data)? parser,
  }) async {
    try {
      final response = await _dio.request(
        path,
        options: Options(method: method, headers: headers),
        queryParameters: queryParameters,
        data: formData != null ? FormData.fromMap(formData) : data,
      );
      if (_logsEnabled) _logs.i(response.data);
      if (parser != null) {
        return HttpResponse.sucsses(parser(response.data));
      }

      return HttpResponse.sucsses(response.data);
    } catch (e) {
      if (_logsEnabled) _logs.e(e);

      int statusCode = -1;
      String message = "Error desconcido";
      dynamic data;

      if (e is DioError) {
        message = e.message;
        if (e.response != null) {
          statusCode = e.response!.statusCode!;
          message = e.response!.statusMessage!;
          data = e.response!.data;
        }
      }

      return HttpResponse.fail(
        statusCode: statusCode,
        message: message,
        data: data,
      );
    }
  }
}
