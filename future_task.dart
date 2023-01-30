import 'dart:async';

import 'dart:io';

void main() {
  Future.delayed(Duration(seconds: 1), (){
    print("into Event loop delayed");

    print("delayed task 1s");
  });

  Future(() {
    print("into Event loop");
    print("will sleep 5s");
    sleep(Duration(seconds: 5));
    print("5s task");
  });

}