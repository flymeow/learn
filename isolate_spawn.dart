import 'dart:async';
import 'dart:io';
import 'dart:isolate';

void main() {
  crate_isolate();
}

Isolate? isolate;

Future crate_isolate() async {
  // 默认执行环境下线程
  ReceivePort rootReceivePort = ReceivePort();
  SendPort rootSendPort = rootReceivePort.sendPort;

  isolate = await Isolate.spawn(subThread, rootSendPort);

  SendPort? port2;

  rootReceivePort.listen((message) {
    print("主线程接收到消息: $message");

    if (message is SendPort) {
      port2 = message;
    } else {
      port2?.send([1, "主线程发送的消息"]);
    }
  });

}

void subThread(SendPort port1) {
  print("new Isolate start");

  ReceivePort receivePort = ReceivePort();
  SendPort port2 = receivePort.sendPort;

  port1.send(port2);

  receivePort.listen((message) {
    print("子线程接受到消息: $message");
  });


  sleep(Duration(seconds: 5));

  port1.send([1, "woWork done"]);

  print("new Isolate end");

  stop();


}

void stop() {
  print("kill");
  isolate?.kill(priority: Isolate.immediate);
  isolate = null;
}
