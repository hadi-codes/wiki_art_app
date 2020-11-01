import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_nav_bar_state.dart';

class HomeNavBarCubit extends Cubit<HomeNavBarState> {
  HomeNavBarCubit() : super(HomeNavBarState(1));
  void changeTo(int index) => emit(HomeNavBarState(index));
}
