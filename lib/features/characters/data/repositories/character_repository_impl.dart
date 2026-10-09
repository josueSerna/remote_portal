import 'package:dio/dio.dart';
import 'package:remote_portal/features/characters/data/datasource/character_remote_datasource.dart';
import 'package:remote_portal/features/characters/domain/entities/charecters_page.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/character.dart';
import '../../domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  const CharacterRepositoryImpl(this._remoteDataSource);

  final CharacterRemoteDatasource _remoteDataSource;

  @override
  Future<CharactersPage> getCharacters({
    required int page,
    String? name,
  }) async {
    try {
      return await _guard(() async {
        final model = await _remoteDataSource.getCharacters(
          page: page,
          name: name,
        );
        return model.toEntity();
      });
    } on NotFoundFailure {
      return const CharactersPage(characters: [], hasNext: false);
    }
  }

  @override
  Future<Character> getCharacter(int id) {
    return _guard(() async {
      final model = await _remoteDataSource.getCharacter(id);
      return model.toEntity();
    });
  }

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (_) {
      throw const UnexpectedFailure('La respuesta del servidor no es válida.');
    }
  }

  Failure _mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutFailure();
      case DioExceptionType.connectionError:
        return const NetworkFailure();
      case DioExceptionType.badResponse:
        final status = e.response?.statusCode ?? 0;
        if (status == 404) return const NotFoundFailure();
        if (status >= 500) return const ServerFailure();
        return ServerFailure('Error del servidor (código $status).');
      case DioExceptionType.cancel:
        return const UnexpectedFailure('La solicitud fue cancelada.');
      default:
        return const UnexpectedFailure();
    }
  }
}
