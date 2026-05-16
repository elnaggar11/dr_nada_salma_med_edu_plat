part of 'language_cubit.dart';

@immutable
sealed class LanguageState {}

final class LanguageInitial extends LanguageState {}


class UpdateLanguageState extends LanguageState {}