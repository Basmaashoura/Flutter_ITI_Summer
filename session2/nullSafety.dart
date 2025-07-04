void main() {
  String? word;
  print(word ?? "Empty");

  List<int>? myList = null;
  print(myList?.length ?? 0);
}