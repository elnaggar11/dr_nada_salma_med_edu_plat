part of 'category_with_blog_cubit.dart';

@immutable
sealed class CategoryWithBlogState {}

final class CategoryWithBlocInitial extends CategoryWithBlogState {}


class CategoriesWithBlogLoadingState extends CategoryWithBlogState {
}

class CategoriesWithBlogErrorState extends CategoryWithBlogState {
  final String message;

  CategoriesWithBlogErrorState({required this.message});
}
class CategoriesWithBlogSuccessState extends CategoryWithBlogState {
  final CategoriesWithBlogResponse categoriesWithBlogResponse;

  CategoriesWithBlogSuccessState({required this.categoriesWithBlogResponse});
}
