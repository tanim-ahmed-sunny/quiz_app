class Category {
  final int id;
  final String name;

  const Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(id: json['id'] as int, name: json['name'] as String);

  /// "Entertainment: Books" -> "Books" (matches the prototype labels).
  String get displayName {
    final i = name.indexOf(': ');
    return i == -1 ? name : name.substring(i + 2);
  }
}
