import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:rxdart/rxdart.dart';
import 'package:wiki_art/Api/src/models/painting.dart';
import 'package:wiki_art/Api/src/wikiArtApi.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this._wikiArtApi)
      : assert(_wikiArtApi != null),
        super(const SearchState.initial());

  final WikiArtApi _wikiArtApi;

  @override
  Stream<Transition<SearchEvent, SearchState>> transformEvents(
    Stream<SearchEvent> events,
    TransitionFunction<SearchEvent, SearchState> transitionFn,
  ) {
    return events
        .debounceTime(const Duration(milliseconds: 350))
        .switchMap(transitionFn);
  }

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchTermChanged) {
      yield* _mapSearchTermChangedToState(event, state);
    }
  }

  Stream<SearchState> _mapSearchTermChangedToState(
    SearchTermChanged event,
    SearchState state,
  ) async* {
    if (event.term.isEmpty) {
      yield const SearchState.initial();
      return;
    }

    if (state.status != SearchStatus.success) {
      yield const SearchState.loading();
    }

    try {
      final results = await _wikiArtApi.searchForPainting(event.term);
      yield SearchState.success(results.painting);
    } on Exception {
      yield const SearchState.failure();
    }
  }
}
