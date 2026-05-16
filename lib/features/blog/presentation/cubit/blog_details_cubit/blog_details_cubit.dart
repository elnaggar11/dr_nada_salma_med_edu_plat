import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/entities/blog_details/blog_by_slug_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/entities/blog_details/blog_details_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/entities/social/social_media_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/usecase/blog_by_category_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/usecase/social_media_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

part 'blog_details_state.dart';

class BlogDetailsCubit extends Cubit<BlogDetailsState> {
  BlogDetailsCubit(this.blogByCategoryUseCase, this.socialMediaUseCase) : super(BlogDetailsInitial());
  final BlogByCategoryUseCase blogByCategoryUseCase;
  final SocialMediaUseCase socialMediaUseCase;
  bool? loading = false;
  bool? error = false;
  bool? success = false;

  bool? socialLoading = false;
  bool? socialError = false;
  bool? socialSuccess = false;

  BlogBySlugResponse? blogBySlugResponse;
  SocialMediaResponse? socialMediaResponse;

  Future<void>getBlogDetails({BlogDetailsParams? params})async{
    loading = true;
    error = false;
    success = false;

    emit(BlogDetailsLoadingState());
    try {
      final failOrUser = await blogByCategoryUseCase(params!);
      failOrUser.fold((fail){
        if(fail is ServerFailure){
          loading = false;
          error = true;
          success = false;
          msgKey.currentState!.showSnackBar(SnackBar(content: Text(fail.message
            ,style: TextStyles.textStyleNormal13.copyWith(color: white),textScaler: TextScaler.linear(1),)));
          emit(BlogDetailsErrorState(message: fail.message));
        }
      }, (response){
        loading = false;
        error = false;
        success = true;
        blogBySlugResponse = response;
        emit(BlogDetailsSuccessState(blogByCategoryIdResponse: response));
      });
    }catch(e){
      loading = false;
      error = true;
      success = false;
    }
  }
  Future<void>getSocial ()async{
    socialLoading = true;
    socialError = false;
    socialSuccess = false;
    emit(BlogSocialLoading());
    try{
      final failOrUser = await socialMediaUseCase(NoParams());
      failOrUser.fold((fail){
        if(fail is ServerFailure){
          socialLoading = false;
          socialError = true;
          socialSuccess = false;
          emit(BlogSocialError(message: fail.message));
        }
      }, (response){
        socialMediaResponse = response;
        socialLoading = false;
        socialError = false;
        socialSuccess = true;
        emit(BlogSocialSuccess(socialMediaResponse: response));
      });
    }catch(e){
      socialLoading = false;
      socialError = true;
      socialSuccess = false;
    }
  }
  Future<void> fetchUrl({String? url}) async {
    if (!await launchUrl(Uri.parse(url!))) {
      throw Exception('Could not launch $url');
    }
  }
}
