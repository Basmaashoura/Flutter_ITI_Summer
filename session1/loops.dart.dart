void main() {
  for (int i = 1; i <= 10; i++) {
    print(i);
  }

  // ================ //

  var i = 1;
  while(i <= 20) {
    if (i%2==0) { 
      print(i);
    }
    i++;
  }

  // ================ //

  i = 10;
  do{
    print(i);
    i--;
  } while(i >= 1);
}