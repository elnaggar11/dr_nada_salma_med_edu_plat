import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/entities/blog_details/blog_by_slug_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/entities/blog_details/blog_details_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/entities/blogs/categories_with_blog_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/entities/social/social_media_response.dart';

abstract class BlogsRepositories{
  Future<Either<Failure,CategoriesWithBlogResponse>>getCategoriesWithBlog();
  Future<Either<Failure,BlogBySlugResponse>>getBlogDetails({BlogDetailsParams? params});
  Future<Either<Failure,SocialMediaResponse>>getSocial();
}