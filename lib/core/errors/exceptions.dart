class AuthException implements Exception {}

class UnAuthorizedException implements Exception {
  final String message;

  UnAuthorizedException({required this.message});
}

class NotFoundException implements Exception {
  final String message;

  NotFoundException({required this.message});
}

class NoCachedUserException implements Exception {}

class NoCachedCartUserException implements Exception {}

class ForbiddenException implements Exception {
  final String message;

  ForbiddenException({required this.message});
}

class CacheException implements Exception {}

class ResetPasswordException implements Exception {}

class StatusException implements Exception {
  final String message;

  StatusException({required this.message});
}

class ServerException implements Exception {
  final String message;

  ServerException({required this.message});
}

class ResetPassWordException implements Exception {}

class AppException implements Exception {
  final String? _message;
  final String? _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, "");
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, "Invalid Request: ");
}

class UnAuthorizedAppException extends AppException {
  UnAuthorizedAppException([message]) : super(message, "Unauthorized: ");
}

class InvalidInputDataException extends AppException {
  InvalidInputDataException([String? message])
    : super(message, "Invalid Input:  ");
}

class UnprocessableContentException extends AppException {
  final String message;

  UnprocessableContentException({required this.message});
}
