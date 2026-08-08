class Recipe {
  final String id;
  final String title;
  final String category;
  final String prepTime;
  final String description;
  final String imageUrl;

  const Recipe({
    required this.id,
    required this.title,
    required this.category,
    required this.prepTime,
    required this.description,
    required this.imageUrl,
  });
}
