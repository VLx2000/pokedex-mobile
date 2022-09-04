class Pokemon {
  final String name;
  final String sprite;

  const Pokemon({
    required this.name,
    required this.sprite,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      sprite: json['sprites']['front_default'],
    );
  }
}
