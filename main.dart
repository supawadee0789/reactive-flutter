Stream<int> getNumbers() async* {
  for (int i = 1; i <= 3; i++) {
    yield i;
    await Future.delayed(const Duration(seconds: 1));
  }
}

Stream<int> getNumbersException() async* {
  for (int i = 1; i <= 3; i++) {
    yield i;
    await Future.delayed(Duration(seconds: 1));
    if (i == 2) {
      throw Exception();
    }
  }
}

Future<void> listen() async {
  getNumbers().listen((data) {
    print(data);
  });

  getNumbersException().listen((data) {
    print(data);
  }).onError((error) {
    print('an error occurred');
  });
}

void main() {
  listen();
}
