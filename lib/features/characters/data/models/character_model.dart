import 'package:remote_portal/features/characters/domain/entities/character.dart';

class CharacterModel {
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

  const CharacterModel({
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

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'] as int,
      name: json['name'] as String,
      status: json['status'] as String,
      species: json['species'] as String,
      type: json['type'] as String,
      gender: json['gender'] as String,
      originName: (json['origin'] as Map<String, dynamic>)['name'] as String,
      locationName:
          (json['location'] as Map<String, dynamic>)['name'] as String,
      image: json['image'] as String,
      episodeCount: (json['episode'] as List<dynamic>).length,
      created: DateTime.parse(json['created'] as String),
    );
  }
  Character toEntity() {
    return Character(
      id: id,
      name: name,
      status: status,
      species: species,
      type: type,
      gender: gender,
      originName: originName,
      locationName: locationName,
      image: image,
      episodeCount: episodeCount,
      created: created,
    );
  }
}
