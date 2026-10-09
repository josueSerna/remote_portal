abstract class Failure implements Exception {
  final String message;

  const Failure(this.message);

  @override
  String toString() => message;
}

class NetworkFailure extends Failure {
  const NetworkFailure([
    super.message = 'No hay conexión a internet. Revisa tu red',
  ]);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure([
    super.message = 'La conexión tardó demasiado. Inténtalo de nuevo',
  ]);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'No se encontró lo que buscas']);
}

class ServerFailure extends Failure {
  const ServerFailure([
    super.message = 'La conexión tardó demasiado. Inténtalo de nuevo',
  ]);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure([super.message = 'Ocurrió un error inesperado']);
}
