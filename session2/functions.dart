void main() {
  int first = 5;
  double second = 3.5;
  print(sumOfTwo(first, second));

  print(greetUser());
  print(greetUser("Basma"));

  print(doubleNum(5));
}

num sumOfTwo (num first, num second) {
  num sum = first + second;
  return sum;
}

String greetUser([String name = 'Guest']) {
  return 'Hello, $name!';
}

int doubleNum(int number) => number * 2;