import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_art/pages/Home/cubit/home_nav_bar_cubit.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeNavBarCubit, HomeNavBarState>(
      builder: (context, state) {
        var bloc = context.read<HomeNavBarCubit>();

        return BottomNavigationBar(
          onTap: (index) => bloc.changeTo(index),
          currentIndex: state.currentIndex,
          backgroundColor: Theme.of(context).backgroundColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Favorite",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star_outline),
              label: "Most Viewed",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
            )
          ],
        );
      },
    );
  }
}
