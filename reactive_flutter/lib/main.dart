import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(Home());
}

class HomeModel {
  final StreamController<int> _numberController =
      StreamController<int>.broadcast();
  Stream<int> get outNumbers => _numberController.stream;
  Sink<int> get inNumbers => _numberController.sink;

  void dispose() {
    _numberController.close();
  }
}

class Home extends StatelessWidget {
  Home({super.key});
  final model = HomeModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Widget1(model), Widget2(model), const RunningNumber()],
        )),
      ),
    );
  }
}

class Widget1 extends StatelessWidget {
  final HomeModel model;
  const Widget1(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: model.outNumbers,
        builder: (context, snapshot) {
          return Text(
              snapshot.data != null ? snapshot.data.toString() : 'no data',
              style: const TextStyle(fontSize: 40));
        });
  }
}

class Widget2 extends StatelessWidget {
  final HomeModel model;
  const Widget2(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          model.inNumbers.add(Random().nextInt(2000));
        },
        child: const Text('press'));
  }
}

Stream<int> getNumbers() async* {
  for (int i = 0; i <= 5; i++) {
    yield i;
    await Future.delayed(const Duration(seconds: 1));
  }
}

class RunningNumber extends StatelessWidget {
  const RunningNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: getNumbers(),
        builder: (context, snapshot) {
          return Text(
              snapshot.data != null ? snapshot.data.toString() : 'no data',
              style: const TextStyle(fontSize: 40));
        });
  }
}
