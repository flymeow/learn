import 'dart:io';

void main() {
  test();
}

test() async {
  // Stream<int> stream = Stream<int>.periodic(Duration(seconds: 1), callback);
  // await for(var i in stream) {
  //   print(i);
  // }
  print("start");

  Future<String> fut1 = Future((){
    sleep(Duration(seconds: 5));
    return "async task1";
  });

  Future<String> fut2 = Future(() {
    return 'async task2';
  });

  Stream<String> stream = Stream<String>.fromFutures([fut1,fut2]);

  await for(var i in stream) {
    print(i);
  }
  print("end");
}


// int callback(int value) {
//   return value;
// }
