import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/entities/blog_details/blog_by_slug_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/entities/blog_details/blog_details_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/repositories/blog_repositories.dart';

class BlogByCategoryUseCase extends UseCase<BlogBySlugResponse,BlogDetailsParams>{
  final BlogsRepositories blogsRepositories;

  BlogByCategoryUseCase(this.blogsRepositories);

  @override
  Future<Either<Failure, BlogBySlugResponse>> call(BlogDetailsParams params) async{
    return await blogsRepositories.getBlogDetails(params: params);
  }

}