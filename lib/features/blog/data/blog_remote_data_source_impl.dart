import 'package:dr_nada_salma_med_edu_plat/core/errors/exceptions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/utils/api_base_helper.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/entities/blog_details/blog_by_slug_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/entities/blog_details/blog_details_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/entities/blogs/categories_with_blog_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/entities/social/social_media_response.dart';

const categoryWithBlogApi = "/category-with-blogs";
const blogDetailsApi = "/blog/";
const socialMediaApi = "/social-media";

abstract class BlogRemoteDataSource {
  Future<CategoriesWithBlogResponse>getCategoriesWithBlog();
  Future<BlogBySlugResponse>getBlogBySlug({BlogDetailsParams params,});
  Future<SocialMediaResponse>getSocial();
}
class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final ApiBaseHelper helper;

  BlogRemoteDataSourceImpl(this.helper);

  @override
  Future<CategoriesWithBlogResponse> getCategoriesWithBlog() async{
    try{
      final response = await helper.get(url: categoryWithBlogApi,);
      return CategoriesWithBlogResponse.fromJson(response);
    }on ServerException catch(e){
      throw ServerException(message: e.message);
    }on UnAuthorizedException catch(e){
      throw UnAuthorizedException(message: e.message);
    }on UnprocessableContentException catch(e){
      throw UnprocessableContentException(message: e.message);
    }
  }

  @override
  Future<BlogBySlugResponse> getBlogBySlug({BlogDetailsParams? params}) async{
    try{
      final response = await helper.get(url: blogDetailsApi+params!.slug!,);
      return BlogBySlugResponse.fromJson(response);
    }on ServerException catch(e){
      throw ServerException(message: e.message);
    }on UnAuthorizedException catch(e){
      throw UnAuthorizedException(message: e.message);
    }on UnprocessableContentException catch(e){
      throw UnprocessableContentException(message: e.message);
    }
  }

  @override
  Future<SocialMediaResponse> getSocial() async{
    try{
      final response = await helper.get(url: socialMediaApi,);
      return SocialMediaResponse.fromJson(response);
    }on ServerException catch(e){
      throw ServerException(message: e.message);
    }on UnAuthorizedException catch(e){
      throw UnAuthorizedException(message: e.message);
    }on UnprocessableContentException catch(e){
      throw UnprocessableContentException(message: e.message);
    }
  }

}