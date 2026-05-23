import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/entities/blogs/categories_with_blog_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/usecase/categories_with_blog_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:flutter/material.dart';

part 'category_with_blog_state.dart';

class CategoryWithBlogCubit extends Cubit<CategoryWithBlogState> {
  CategoryWithBlogCubit(this.categoriesWithBlogUseCase)
    : super(CategoryWithBlocInitial());
  final CategoriesWithBlogUseCase categoriesWithBlogUseCase;
  bool? loading = false;
  bool? error = false;
  bool? success = false;
  CategoriesWithBlogResponse? categoriesWithBlogResponse;

  Future<void> getCategoriesWithBlog() async {
    loading = true;
    error = false;
    success = false;
    emit(CategoriesWithBlogLoadingState());
    try {
      final failOrUser = await categoriesWithBlogUseCase(NoParams());
      failOrUser.fold(
        (fail) {
          if (fail is ServerFailure) {
            loading = false;
            error = true;
            success = false;
            msgKey.currentState!.showSnackBar(
              SnackBar(
                content: Text(
                  fail.message,
                  style: TextStyles.textStyleNormal13.copyWith(color: white),
                  textScaler: TextScaler.linear(1),
                ),
              ),
            );
            emit(CategoriesWithBlogErrorState(message: fail.message));
          }
        },
        (response) {
          categoriesWithBlogResponse = response;
          loading = false;
          error = false;
          success = true;

          emit(
            CategoriesWithBlogSuccessState(
              categoriesWithBlogResponse: response,
            ),
          );
        },
      );
    } catch (e) {
      loading = false;
      error = true;
      success = false;
    }
  }
}
