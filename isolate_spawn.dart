import 'dart:io';
import 'dart:isolate';

void main () {
  crate_isolate();
}

Future crate_isolate() async {
  // 默认执行环境下线程
  ReceivePort rootReceivePort = ReceivePort();
  SendPort rootSendPort = rootReceivePort.sendPort;

  await Isolate.spawn(doWork, rootSendPort);

  SendPort? port2;

  rootReceivePort.listen((message) {
    print("main isolate message: $message");
    if(message[0] == 0) {
      port2 = message[1];
    } else {
      port2?.send([1, "main isolate message"]);
    }
  });
  print("主线程结束");
}

void doWork(SendPort port1) {
  print("新线程开始");

  ReceivePort receivePort = ReceivePort();
  SendPort port2 = receivePort.sendPort;

  receivePort.listen((message) { print("doWork message: $message");});

  port1.send([0, port2]);

  sleep(Duration(seconds: 5));

  port1.send([1, "woWork done"]);

  print("new isolate end");
}
