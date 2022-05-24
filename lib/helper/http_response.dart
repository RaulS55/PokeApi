class HttpResponse<T> {
  final T? data; //Guardo los datos retornados
  final HttpError? error;

  HttpResponse(this.data, this.error); //Guardo el codigo de error

  static HttpResponse<T> sucsses<T>(T data) => HttpResponse(data, null);
  static HttpResponse<T> fail<T>({
    required int statusCode,
    required String message,
    required dynamic data,
  }) =>
      HttpResponse(null,
          HttpError(statusCode: statusCode, message: message, data: data));
}

class HttpError {
  final int statusCode;
  final String message;
  final dynamic data;

  HttpError({
    required this.statusCode,
    required this.message,
    required this.data,
  }); //guarda los datos de retorno en caso de errores
}
