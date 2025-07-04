void main() {
  int first = 5;
  int second = 10;

  String evenOrOdd (int number) {
    if(number %2 == 0 && number != 0) {
      return "even";
    }
    else {
      return "odd";
    }
  }

  print(evenOrOdd(first));
  print(evenOrOdd(second));

  // ================ //

  num maxNum (num first, second, third) {
    if(first > second && first > third) {
      return first;
    } else if (second > first && second > third) {
      return second;
    } else {
      return third;
    }
  }

  num n1 = 75;
  num n2 = 125; 
  num n3 = 75.6;
  print(maxNum(n1, n2, n3));

  // ================ //
  
  int dayNum = 5;
  switch(dayNum) {
    case 1: 
      print("Friday");
      break;

    case 2: 
      print("Saturday");
      break;

    case 3: 
      print("Sunday");
      break;

    case 4: 
      print("Monday");
      break;

    case 5: 
      print("Tuesday");
      break;

    case 6: 
      print("Wednesday");
      break;

    case 7: 
      print("Thursday");
      break;
  }
}