void main() {
  List<int> integers = [1, 2, 3, 4, 5];
  int sum = 0;
  for (int i = 0; i < integers.length; i++) {
    sum += integers[i];
  }

  print(sum);

    // ================ //
  
  Map<String, String> countryCapital = {
  'Egypt': 'Cairo',
  'Yemen': 'Sanaa',
  'Jordan': 'Amman'
  };

  countryCapital.forEach((key,value) => print('${key}: ${value}')); 

    // ================ //

  List<int> numbers = [5, 87, 79, 890];
  numbers.sort();
  print(numbers[numbers.length-1]);
}