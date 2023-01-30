import 'dart:convert';
import 'dart:io';

void main() {
 startTCPServer();
}

void startTCPServer() async {
  ServerSocket serverSocket = await ServerSocket.bind(InternetAddress.loopbackIPv4, 8081);
  
  await for(Socket socket in serverSocket) {
    socket.cast<List<int>>().transform(utf8.decoder).listen((event) { 
      print("${socket.remoteAddress.address} data:" + event);
      socket.add(utf8.encode('hello client!'));
    });
  }
}

