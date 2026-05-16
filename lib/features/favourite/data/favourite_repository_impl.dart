import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/exceptions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/data/favourite_remote_data_source_impl.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/domain/entities/add_to_favourite_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/domain/entities/favourite_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/domain/entities/favourtie_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/domain/favourite_repositories.dart';

class FavouritesRepositoryImpl implements FavouriteRepositories {
  final FavouriteRemoteDataSource favouriteRemoteDataSource;

  FavouritesRepositoryImpl(this.favouriteRemoteDataSource);

  @override
  Future<Either<Failure, AddToFavouriteResponse>> addToFavourite({FavouriteParams? params}) async{
    try{
      final response = await favouriteRemoteDataSource.addToFavourite(params: params);
      return Right(response);
    }on ServerException catch(e){
      return left(ServerFailure(message: e.message));
    }on UnAuthorizedException catch(e){
      return left(ServerFailure(message: e.message));
    }on UnprocessableContentException catch(e){
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, FavouriteResponse>> getMyFavourites() async{
    try{
      final response = await favouriteRemoteDataSource.getMyFavourite();
      return Right(response);
    }on ServerException catch(e){
      return left(ServerFailure(message: e.message));
    }on UnAuthorizedException catch(e){
      return left(ServerFailure(message: e.message));
    }on UnprocessableContentException catch(e){
      return left(ServerFailure(message: e.message));
    }
  }



}