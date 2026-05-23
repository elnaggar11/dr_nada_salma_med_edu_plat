import 'package:dr_nada_salma_med_edu_plat/core/errors/exceptions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/utils/api_base_helper.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/domain/entities/add_to_favourite_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/domain/entities/favourite_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/domain/entities/favourtie_response.dart';

const addFavouriteApi = "/toggle-favourite/";
const favouritesApi = "/my-favourites";

abstract class FavouriteRemoteDataSource {
  Future<AddToFavouriteResponse> addToFavourite({FavouriteParams? params});
  Future<FavouriteResponse> getMyFavourite();
}

class FavouriteRemoteDataSourceImpl implements FavouriteRemoteDataSource {
  final ApiBaseHelper helper;

  FavouriteRemoteDataSourceImpl(this.helper);

  @override
  Future<AddToFavouriteResponse> addToFavourite({
    FavouriteParams? params,
  }) async {
    try {
      final response = await helper.post(
        url: addFavouriteApi + params!.favouriteId!,
        body: {},
      );
      return AddToFavouriteResponse.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    }
  }

  @override
  Future<FavouriteResponse> getMyFavourite() async {
    try {
      final response = await helper.get(url: favouritesApi);
      return FavouriteResponse.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    }
  }
}
