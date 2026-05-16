import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<Type,Params>{
  Future<Either<Failure,Type>>call(Params params);
}
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];

}