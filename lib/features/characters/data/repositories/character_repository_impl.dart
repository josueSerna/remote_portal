import 'package:dio/dio.dart';
import 'package:remote_portal/core/error/failure.dart';
import 'package:remote_portal/features/characters/data/datasource/character_remote_datasource.dart';
import 'package:remote_portal/features/characters/domain/entities/character.dart';
import 'package:remote_portal/features/characters/domain/entities/charecters_page.dart';
import 'package:remote_portal/features/characters/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDatasource _remoteDatasource;

  CharacterRepositoryImpl(this._remoteDatasource);

  @override
  Future<CharactersPage> getCharacters({required int page}) {
    return _guard(() async {
      final model = await _remoteDatasource.getCharacters(page: page);
      return model.toEntity();
    });
  }

  @override
  Future<Character> getCharacter(int id) {
    return _guard(() async {
      final model = await _remoteDatasource.getCharacter(id);
      return model.toEntity();
    });
  }

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (_) {
      throw const UnexpectedFailure('La respuesta del servidor no es válida');
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
