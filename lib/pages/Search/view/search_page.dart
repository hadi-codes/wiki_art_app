import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_art/Api/src/wikiArtApi.dart';
import 'package:wiki_art/pages/Search/bloc/search_bloc.dart';
import 'package:wiki_art/pages/Search/view/view.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: BlocProvider(
            create: (context) => SearchBloc(
              context.repository<WikiArtApi>(),
            ),
            child: SearchForm(),
          ),
        ),
      ),
    );
  }
}
