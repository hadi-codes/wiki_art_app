part of 'search_bloc.dart';

enum SearchStatus { initial, loading, success, failure }

class SearchState extends Equatable {
  const SearchState._({
    this.status = SearchStatus.initial,
    this.paintings = const <Painting>[],
  });

  const SearchState.initial() : this._();

  const SearchState.loading() : this._(status: SearchStatus.loading);

  const SearchState.success(List<Painting> paintings)
      : this._(status: SearchStatus.success, paintings: paintings);

  const SearchState.failure() : this._(status: SearchStatus.failure);

  final SearchStatus status;
  final List<Painting> paintings;

  @override
  List<Object> get props => [status, paintings];
}
