import 'package:dio/dio.dart';
import 'package:remote_portal/features/characters/data/models/character_model.dart';
import 'package:remote_portal/features/characters/data/models/characters_page_model.dart';

class CharacterRemoteDatasource {
  final Dio _dio;

  CharacterRemoteDatasource(this._dio);

  Future<CharactersPageModel> getCharacters({required int page}) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/character',
      queryParameters: {'page': page},
    );
    return CharactersPageModel.fromJson(response.data!);
  }

  Future<CharacterModel> getCharacter(int id) async {
    final response = await _dio.get<Map<String, dynamic>>('/character/$id');
    return CharacterModel.fromJson(response.data!);
  }
}
