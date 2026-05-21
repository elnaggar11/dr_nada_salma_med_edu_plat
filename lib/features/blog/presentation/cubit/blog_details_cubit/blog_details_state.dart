part of 'blog_details_cubit.dart';

@immutable
sealed class BlogDetailsState {}

final class BlogDetailsInitial extends BlogDetailsState {}

class BlogDetailsLoadingState extends BlogDetailsState {}

class BlogDetailsErrorState extends BlogDetailsState {
  final String message;

  BlogDetailsErrorState({required this.message});
}

class BlogDetailsSuccessState extends BlogDetailsState {
  final BlogBySlugResponse blogByCategoryIdResponse;

  BlogDetailsSuccessState({required this.blogByCategoryIdResponse});
}

class BlogSocialLoading extends BlogDetailsState {}

class BlogSocialError extends BlogDetailsState {
  final String message;

  BlogSocialError({required this.message});
}

class BlogSocialSuccess extends BlogDetailsState {
  final SocialMediaResponse socialMediaResponse;

  BlogSocialSuccess({required this.socialMediaResponse});
}
