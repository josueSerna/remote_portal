import 'package:remote_portal/features/characters/domain/entities/character.dart';
import 'package:remote_portal/features/characters/domain/entities/charecters_page.dart';

abstract class CharacterRepository {
  Future<CharactersPage> getCharacters({required int page, String? name});

  Future<Character> getCharacter(int id);
}
