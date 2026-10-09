import 'package:remote_portal/features/characters/domain/entities/character.dart';
import 'package:remote_portal/features/characters/domain/repositories/character_repository.dart';

class GetCharacterDetail {
  final CharacterRepository _repository;

  const GetCharacterDetail(this._repository);

  Future<Character> call(int id) {
    return _repository.getCharacter(id);
  }
}
