class Pokemon {
  final String name;
  final int id;
  final String sprite;
  final String logo;
  final List<dynamic> tipos;
  final List<dynamic> stats;
  final int weight;
  final int height;

  const Pokemon({
    required this.name,
    required this.id,
    required this.sprite,
    required this.logo,
    required this.tipos,
    required this.stats,
    required this.weight,
    required this.height,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      id: json['id'],
      sprite: json['sprites']['other']['official-artwork']['front_default'],
      logo: json['sprites']['front_default'],
      tipos: json['types'],
      stats: json['stats'],
      height: json['height'],
      weight: json['weight'],
    );
  }
}
