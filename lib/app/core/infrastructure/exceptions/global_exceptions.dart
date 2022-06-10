class NoInternetConnectionException implements Exception {
  const NoInternetConnectionException();
}

class ServerException implements Exception {
  final String data;

  const ServerException({required this.data});
}

class CacheException implements Exception {
  const CacheException();
}
