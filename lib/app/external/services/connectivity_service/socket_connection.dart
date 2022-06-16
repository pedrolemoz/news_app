import 'dart:io';

class SocketConnection {
  final InternetAddress address;
  final int port;
  final Duration timeout;

  const SocketConnection(
    this.address, {
    this.port = 53,
    this.timeout = const Duration(seconds: 10),
  });

  Future<bool> connect() async {
    try {
      return await Socket.connect(address, port, timeout: timeout).then(
        (socket) {
          socket.close();
          return true;
        },
      );
    } catch (exception) {
      return false;
    }
  }
}
