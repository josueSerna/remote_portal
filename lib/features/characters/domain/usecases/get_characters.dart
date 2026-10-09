import 'package:remote_portal/features/characters/domain/entities/charecters_page.dart';
import 'package:remote_portal/features/characters/domain/repositories/character_repository.dart';

class GetCharacters {
  final CharacterRepository _repository;

  const GetCharacters(this._repository);

  Future<CharactersPage> call({required int page}) {
    return _repository.getCharacters(page: page);
  }
}
