import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/entities/social/social_media_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/repositories/blog_repositories.dart';

class SocialMediaUseCase extends UseCase<SocialMediaResponse, NoParams> {
  final BlogsRepositories blogsRepositories;

  SocialMediaUseCase(this.blogsRepositories);

  @override
  Future<Either<Failure, SocialMediaResponse>> call(NoParams params) async {
    return await blogsRepositories.getSocial();
  }
}
