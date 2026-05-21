import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/entities/blogs/categories_with_blog_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/repositories/blog_repositories.dart';

class CategoriesWithBlogUseCase
    extends UseCase<CategoriesWithBlogResponse, NoParams> {
  final BlogsRepositories blogsRepositories;

  CategoriesWithBlogUseCase(this.blogsRepositories);

  @override
  Future<Either<Failure, CategoriesWithBlogResponse>> call(
    NoParams params,
  ) async {
    return await blogsRepositories.getCategoriesWithBlog();
  }
}
