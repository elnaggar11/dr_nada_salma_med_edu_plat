import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/exceptions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/data/blog_remote_data_source_impl.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/entities/blog_details/blog_by_slug_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/entities/blog_details/blog_details_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/entities/blogs/categories_with_blog_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/entities/social/social_media_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/repositories/blog_repositories.dart';

class BlogRepositoriesImpl implements BlogsRepositories {
  final BlogRemoteDataSource blogRemoteDataSource;

  BlogRepositoriesImpl(this.blogRemoteDataSource);

  @override
  Future<Either<Failure, CategoriesWithBlogResponse>>
  getCategoriesWithBlog() async {
    try {
      final response = await blogRemoteDataSource.getCategoriesWithBlog();
      return Right(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    }
  }

  @override
  Future<Either<Failure, BlogBySlugResponse>> getBlogDetails({
    BlogDetailsParams? params,
  }) async {
    try {
      final response = await blogRemoteDataSource.getBlogBySlug(
        params: params!,
      );
      return Right(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    }
  }

  @override
  Future<Either<Failure, SocialMediaResponse>> getSocial() async {
    try {
      final response = await blogRemoteDataSource.getSocial();
      return Right(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    }
  }
}
