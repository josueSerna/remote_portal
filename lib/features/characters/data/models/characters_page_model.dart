import 'package:remote_portal/features/characters/data/models/character_model.dart';
import 'package:remote_portal/features/characters/domain/entities/charecters_page.dart';

class CharactersPageModel {
  final List<CharacterModel> characters;
  final bool hasNext;

  const CharactersPageModel({required this.characters, required this.hasNext});

  factory CharactersPageModel.fromJson(Map<String, dynamic> json) {
    final results = (json['results'] as List<dynamic>)
        .map((e) => CharacterModel.fromJson(e as Map<String, dynamic>))
        .toList();
    final info = json['info'] as Map<String, dynamic>;

    return CharactersPageModel(
      characters: results,
      hasNext: info['next'] != null,
    );
  }

  CharactersPage toEntity() {
    return CharactersPage(
      characters: characters.map((c) => c.toEntity()).toList(),
      hasNext: hasNext,
    );
  }
}
