import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remote_portal/core/network/dio_provider.dart';
import 'package:remote_portal/features/characters/data/datasource/character_remote_datasource.dart';
import 'package:remote_portal/features/characters/data/repositories/character_repository_impl.dart';
import 'package:remote_portal/features/characters/domain/repositories/character_repository.dart';
import 'package:remote_portal/features/characters/domain/usecases/get_character_detail.dart';
import 'package:remote_portal/features/characters/domain/usecases/get_characters.dart';

final characterRemoteDataSourceProvider = Provider<CharacterRemoteDatasource>((
  ref,
) {
  return CharacterRemoteDatasource(ref.watch(dioProvider));
});

final characterRepositoryProvider = Provider<CharacterRepository>((ref) {
  return CharacterRepositoryImpl(ref.watch(characterRemoteDataSourceProvider));
});

final getCharactersProvider = Provider<GetCharacters>((ref) {
  return GetCharacters(ref.watch(characterRepositoryProvider));
});

final getCharacterDetailProvider = Provider<GetCharacterDetail>((ref) {
  return GetCharacterDetail(ref.watch(characterRepositoryProvider));
});
