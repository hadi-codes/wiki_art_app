part of 'home_nav_bar_cubit.dart';

class HomeNavBarState extends Equatable {
  const HomeNavBarState(this.currentIndex);
  final int currentIndex;
  @override
  List<Object> get props => [currentIndex];
}
