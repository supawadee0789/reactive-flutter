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

void awaitFor() async {
  var sum = 0;
  await for (int number in getNumbers()) {
    sum += number;
  }
  print(sum);
}

void isEmpty() async {
  if (await getNumbers().isEmpty) {
    print('stream is empty');
  } else {
    print('stream is not empty');
  }
}

void expand() {
  getNumbers().expand((data) => [data, data * 10]).listen((item) {
    print(item);
  });
}

// Mutate data one-by-one
void map() {
  getNumbers().map((i) => i * 10).listen((item) {
    print(item);
  });
}

// Skip n elements from fist element
void skip() {
  getNumbers().skip(2).listen((item) {
    print(item);
  });
}

// Skip until condition return true
void skipWhile() {
  getNumbers().skipWhile((i) => i < 3).listen((item) {
    print(item);
  });
}

// Take only the first n elements
void take() {
  getNumbers().take(2).listen((item) {
    print(item);
  });
}

// Take item until condition return true
void takeWhile() {
  getNumbers().takeWhile((item) => item <= 2).listen((item) {
    print(item);
  });
}

void main() {
  // listen();
  // awaitFor();
  // isEmpty();
  // expand();
  // map();
  // skip();
  // skipWhile();
  // take();
  takeWhile();
}
