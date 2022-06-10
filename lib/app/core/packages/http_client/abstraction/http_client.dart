import '../entities/http_response.dart';

abstract class HttpClient {
  Future<HttpResponse> get(
    String url, {
    Map<String, String>? headers,
    bool responseAsBodyBytes = false,
  });

  Future<HttpResponse> post(
    String url, {
    dynamic body,
    Map<String, String>? headers,
    bool responseAsBodyBytes = false,
  });
}
