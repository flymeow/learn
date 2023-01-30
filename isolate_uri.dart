import 'dart:isolate';

void main() {
  create_isolate();
}

Future create_isolate() async {
  ReceivePort receivePort = ReceivePort();

  await Isolate.spawnUri(
      Uri(path: "./work_task.dart"), ["hello"], receivePort.sendPort);

  SendPort? port2;

  receivePort.listen((message) {
    print("main isolate message: $message");
    if (message[0] == 0) {
      port2 = message[1];
    } else {
      port2?.send([1, "这条信息是 main isolate 发送的"]);
    }
  });
}
