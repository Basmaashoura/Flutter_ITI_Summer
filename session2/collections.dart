void main() {
  List<String> movies = ["movie1", "movie2", "movie3"];
  print(movies);

  movies.add("added movie");
  print(movies);

  // =========== //

  Set<String> colors = {"Red", "Green", "Blue"};
  colors.add("black");
  print(colors);

  // =========== //

  Map<String, String> countryCapital = {
  'Egypt': 'Cairo',
  'Jordan': 'Amman'
  };

  countryCapital.forEach((key,value) => print('${key}: ${value}')); 

}  