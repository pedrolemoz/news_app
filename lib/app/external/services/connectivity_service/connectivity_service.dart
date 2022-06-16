import 'dart:io';

import 'socket_connection.dart';

abstract class ConnectivityService {
  Future<bool> hasActiveNetwork();
}

class ConnectivityServiceImplementation implements ConnectivityService {
  static final List<SocketConnection> _socketConnections = List.unmodifiable([
    SocketConnection(InternetAddress('8.8.8.8')),
    SocketConnection(InternetAddress('1.1.1.1')),
    SocketConnection(InternetAddress('208.67.222.222')),
  ]);

  @override
  Future<bool> hasActiveNetwork() async {
    for (final socketConnection in _socketConnections) {
      var result = await socketConnection.connect();
      if (result) return true;
    }
    return false;
  }
}
