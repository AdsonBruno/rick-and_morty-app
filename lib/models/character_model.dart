class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String image;
  final String lastLocationName;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.image,
    required this.lastLocationName,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      image: json['image'],
      lastLocationName: json['location']['name'] ?? 'Unknown',
    );
  }
}
