import 'dart:io';
  List<Map<String,String>> libraryDataBase = [];

void main() {
  Map<int, String> services = {
                              1 : "Add a new book", 
                              2 : "Remove a book by a title",
                              3 : "View all books", 
                              4 : "Search by title",
                              5 : "Update author name",
                              6 : "Count books"
                              };
     
    print(libraryDataBase);
    while (true) {
      services.forEach((key,value) => print('${key}: ${value}')); 
    print("Choose Service Number");
    int? serviceNum = int.parse(stdin.readLineSync()!);
    executeUserOption(serviceNum);
  }
}

void executeUserOption (int serviceNum) {
    Map<int, Function> menuOptions = {
      1: () => addBook(),
      2: () => removeByTitle(),
      3: () => viewAllBooks(),
      4: () => searchByTitle(),
      5: () => updateAuthor(),
      6: () => bookCount()
    };
    
    menuOptions[serviceNum]?.call();
}

void addBook() {
  print("enter book title:");
  String? title = stdin.readLineSync();

  print("enter book author:");
  String? author = stdin.readLineSync();

  libraryDataBase.add({'title': title ?? '', 'author' : author ?? ''});
}

void removeByTitle() {
  if(libraryDataBase.isEmpty) {
    return;
  }
  print("enter book title:");
  String? title = stdin.readLineSync();
  libraryDataBase.removeWhere((book) => book['title']?.toLowerCase() == title?.toLowerCase());
  print(libraryDataBase);

  return;
}

void viewAllBooks() {
  print(libraryDataBase);
  return;
}

void searchByTitle() {
  if(libraryDataBase.isEmpty) {
    return;
  }
  print("enter book title:");
  String? title = stdin.readLineSync();
  bool found = false;
  libraryDataBase.forEach((book) {
    if (book['title']?.toLowerCase() == title?.toLowerCase()) {
      print('Found: ${book}');
      found = true;
    }
  });
  if (!found) {
    print('No book found with that title.');
  }
}

void updateAuthor() {
  print("enter book title:");
  String? title = stdin.readLineSync();
  libraryDataBase.forEach((book) {
    if (book['title']?.toLowerCase() == title?.toLowerCase()) {
      print('Book is found: ${book}');
      print("Enter new author name:");
      String newAuthor = stdin.readLineSync() ?? 'unknown';
      book['author'] = newAuthor;
      print(book);
    }
  });
}

void bookCount() {
  print(libraryDataBase.length);
}