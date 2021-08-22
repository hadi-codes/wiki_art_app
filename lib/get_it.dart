import 'package:get_it/get_it.dart';
import 'package:wiki_art/Api/src/wikiArtApi.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<WikiArtApi>(WikiArtApi());
}
