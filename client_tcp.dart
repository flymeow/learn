import 'dart:convert';
import 'dart:io';

void main() {
  Socket.connect('127.0.0.1', 8081).then((socket) {
    socket.write('hello, server');
    socket.cast<List<int>>().transform(utf8.decoder).listen(print);
  });
}
