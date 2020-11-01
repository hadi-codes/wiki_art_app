import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_art/pages/Home/NavBar/nav_bar.dart';
import 'package:wiki_art/pages/Home/cubit/home_nav_bar_cubit.dart';
import 'package:wiki_art/pages/Search/view/view.dart';
import './../pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MostViewedPage _mostViewedPage = MostViewedPage();
  final SearchPage _searchPage = SearchPage();
  final FavoritePage _favoritePage = FavoritePage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeNavBarCubit(),
      child: BlocBuilder<HomeNavBarCubit, HomeNavBarState>(
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(
              index: state.currentIndex,
              children: [
                _favoritePage,
                _mostViewedPage,
                _searchPage,
              ],
            ),
            bottomNavigationBar: NavBar(),
          );
        },
      ),
    );
  }
}
