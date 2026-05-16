import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  @override
  List<Object?> get props => [];

}
class AuthFailure extends Failure{
  final String message;

  AuthFailure({required this.message});
}
class CacheFailure extends Failure{
  final String message;

  CacheFailure(this.message);
}
class ServerFailure extends Failure{
  final String message;

  ServerFailure({required this.message});
}
class ContentServerFailure extends Failure{
  final String message;

  ContentServerFailure({required this.message});
}
class NoCachedUserFailure extends Failure{

  NoCachedUserFailure();
}
class StatusFailure extends Failure{
  final String message;

  StatusFailure({required this.message});
}