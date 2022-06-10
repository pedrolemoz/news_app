import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../../../infrastructure/exceptions/global_exceptions.dart';
import '../../network_connectivity_checker/abstractions/network_connectivity_checker.dart';
import '../abstraction/http_client.dart';
import '../entities/http_response.dart';

class HttpClientImplementation implements HttpClient {
  final http.Client httpClient;
  final NetworkConnectivityChecker connectivityChecker;

  const HttpClientImplementation(this.httpClient, this.connectivityChecker);

  @override
  Future<HttpResponse> get(
    String url, {
    Map<String, String>? headers,
    bool responseAsBodyBytes = false,
  }) async {
    if (await connectivityChecker.hasActiveNetwork()) {
      try {
        final response = await httpClient.get(Uri.parse(url), headers: headers);

        return responseAsBodyBytes
            ? HttpResponse<Uint8List>(
                url: url,
                data: response.bodyBytes,
                statusCode: response.statusCode,
              )
            : HttpResponse<String>(
                url: url,
                data: response.body,
                statusCode: response.statusCode,
              );
      } catch (exception) {
        throw ServerException(data: exception.toString());
      }
    }

    throw const NoInternetConnectionException();
  }

  @override
  Future<HttpResponse> post(
    String url, {
    dynamic body,
    Map<String, String>? headers,
    bool responseAsBodyBytes = false,
  }) async {
    if (await connectivityChecker.hasActiveNetwork()) {
      try {
        final response = await httpClient.post(
          Uri.parse(url),
          body: body,
          headers: headers,
        );

        return responseAsBodyBytes
            ? HttpResponse<Uint8List>(
                url: url,
                data: response.bodyBytes,
                statusCode: response.statusCode,
              )
            : HttpResponse<String>(
                url: url,
                data: response.body,
                statusCode: response.statusCode,
              );
      } catch (exception) {
        throw ServerException(data: exception.toString());
      }
    }

    throw const NoInternetConnectionException();
  }
}
