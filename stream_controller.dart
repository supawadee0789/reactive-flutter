import 'dart:async';

StreamController<String> _controllerA = StreamController<String>();
Stream<String> get outA => _controllerA.stream;

// Can listen to multiple stream
StreamController<String> _controllerB = StreamController<String>.broadcast();
Stream<String> get outB => _controllerB.stream;

void main() {
  outA.listen((data) {
    print(data);
  });

  outB.listen((data) {
    print(data);
  });

  outB.listen((data) {
    print(data.replaceAll('a', 'b'));
  });

  addA();
  addB();
}

void addA() {
  _controllerA.sink.add('A >> somedata');
}

void addB() {
  _controllerB.sink.add('B >> somedata');
}
