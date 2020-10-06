import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wiki_art/Api/src/wikiArtApi.dart';

part 'wiki_art_api_state.dart';

class WikiArtApiCubit extends Cubit<WikiArtApiState> {
  WikiArtApiCubit(this.wikiArtApi)
      : assert(wikiArtApi != null),
        super(WikiArtApiState(wikiArtApi));

  final WikiArtApi wikiArtApi;
}
