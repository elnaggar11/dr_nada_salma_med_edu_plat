part of 'bottom_bar_cubit.dart';

@immutable
sealed class BottomBarState {}

final class BottomBarInitial extends BottomBarState {}


class BottomBarUpdateState extends BottomBarState {}

class BottomBarUpdateState2 extends BottomBarState {}

class UpdateIndexState extends BottomBarState {}

class UpdateBottomBarVisibility extends BottomBarState {}