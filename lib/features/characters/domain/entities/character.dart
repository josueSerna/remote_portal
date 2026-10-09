class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String originName;
  final String locationName;
  final String image;
  final int episodeCount;
  final DateTime created;

  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.originName,
    required this.locationName,
    required this.image,
    required this.episodeCount,
    required this.created,
  });
}
