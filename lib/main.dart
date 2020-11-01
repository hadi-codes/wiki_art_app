import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wiki_art/Api/cubit/wiki_art_api_cubit.dart';
import 'package:wiki_art/Api/wikiArtApi.dart';
import 'package:wiki_art/pages/pages.dart';
import 'Routes/routes.dart';
import 'Theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Routes.defineRoutes(router);

  //await DefaultCacheManager().emptyCache();

  WikiArtApi wikiArtApi = WikiArtApi();
  // await wikiArtApi.init();

  runApp(MyApp(
    wikiArtApi: wikiArtApi,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key, this.wikiArtApi}) : super(key: key);

  final WikiArtApi wikiArtApi;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: wikiArtApi,
      child: BlocProvider(
        create: (context) => WikiArtApiCubit(wikiArtApi),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.themeData,
          home: HomePage(),
        ),
      ),
    );
  }
}
