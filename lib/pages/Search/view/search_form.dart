import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wiki_art/Api/src/models/painting.dart';
import 'package:wiki_art/pages/Search/bloc/search_bloc.dart';
import 'package:wiki_art/pages/Search/widgets/widgets.dart';

class SearchForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SearchBar(
          onChanged: (term) {
            context.bloc<SearchBloc>().add(SearchTermChanged(term));
          },
        ),
        _SearchContent()
      ],
    );
  }
}

class _SearchContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == SearchStatus.failure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('oops try again!')),
            );
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case SearchStatus.loading:
            return const _SearchLoading();
          case SearchStatus.success:
            return _SearchSuccess(paintings: state.paintings);
          default:
            return const _SearchInitial();
        }
      },
    );
  }
}

class _SearchLoading extends StatelessWidget {
  const _SearchLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _SearchSuccess extends StatelessWidget {
  const _SearchSuccess({Key key, @required this.paintings}) : super(key: key);

  final List<Painting> paintings;

  @override
  Widget build(BuildContext context) {
    return SearchResults(
      paintings: paintings,
      onTap: (suggestion) {
        // Navigator.of(context).push<void>(
        //   SynonymsPage.route(word: suggestion.value),
        // );
      },
    );
  }
}

class _SearchInitial extends StatelessWidget {
  const _SearchInitial({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SliverToBoxAdapter(
      child: Center(
        child: Text(
          'Find some Art ✨',
          key: const Key('search_initial_text'),
          style: textTheme.headline6,
        ),
      ),
    );
  }
}
