class Pokemon {
  final String name;
  final int id;
  final String sprite;
  final List<dynamic> tipos;

  const Pokemon({
    required this.name,
    required this.id,
    required this.sprite,
    required this.tipos,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      id: json['id'],
      sprite: json['sprites']['front_default'],
      tipos: json['types'],
    );
  }
}
