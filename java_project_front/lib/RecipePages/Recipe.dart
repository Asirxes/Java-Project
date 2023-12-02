class Recipe {
  final int id;
  final String name;
  final String text;

  Recipe({required this.id, required this.name, required this.text});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      name: json['name'],
      text: json['text'],
    );
  }
}
