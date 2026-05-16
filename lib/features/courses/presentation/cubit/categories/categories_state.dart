part of 'categories_cubit.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}


class CategoriesErrorState extends CategoriesState {
  final String msg;

  CategoriesErrorState({required this.msg});
}
class CategoriesLoadingState extends CategoriesState {}

class CategoriesSuccessState extends CategoriesState {
  final CategoriesResponse categoriesResponse;

  CategoriesSuccessState({required this.categoriesResponse});
}

class UpdateCategoryTypeState extends CategoriesState {}

class FilterUpdateItemState extends CategoriesState {}