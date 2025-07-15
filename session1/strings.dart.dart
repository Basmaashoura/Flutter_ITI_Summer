void main() {
  String s1 = 'Ba';
  String s2 = 'sma';
  print(s1 + s2);

  // ================ //
  
  String s3 = 'Aeiou';
  String s32 = 'abcdef';
  
  int numOfVowels2 (String s) {
    int counter = 0;
    String vowels = 'aeiouAEIOU';  
    for (int i = 0; i < s.length; i++) {
      if (vowels.contains(s[i])) {
        counter++;
      }
    }
  
    return counter;
  }

  print(numOfVowels2(s3));
  print(numOfVowels2(s32));
  // ================ //

  String s4 = 'basma';
  print(s4.toUpperCase());

  String s5 = 'FLUTTER';
  print(s5.toLowerCase());
}