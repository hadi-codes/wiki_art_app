import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wiki_art/Api/cubit/wiki_art_api_cubit.dart';
import 'package:wiki_art/Api/wikiArtApi.dart';

import 'Widgets/widgets.dart';
import 'models/dataSource.dart';

class MostViewedPage extends StatefulWidget {
  MostViewedPage({Key key}) : super(key: key);

  @override
  _MostViewedPageState createState() => _MostViewedPageState();
}

class _MostViewedPageState extends State<MostViewedPage> {
  ScrollController controller;

  @override
  void initState() {
    controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("WikiArt"),
      ),
      body: WillPopScope(onWillPop: () async {
        if (controller.offset == 0)
          return true;
        else
          controller.animateTo(
            0.0,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );
        return false;
      }, child: BlocBuilder<WikiArtApiCubit, WikiArtApiState>(
        builder: (context, state) {
          var api = context.bloc<WikiArtApiCubit>().wikiArtApi;
          return RefreshIndicator(
            onRefresh: () => api.getMostViwedPaintings(
                mostViewedPaintings: MostViewedPaintings()),
            child: PagedListView<int, Painting>.separated(
              controller: controller,
              dataSource: PaintingListViewDataSource(api),
              builderDelegate: PagedChildBuilderDelegate<Painting>(
                itemBuilder: (context, item, index) => PaintingListItem(
                  wikiApi: api,
                  painting: item,
                ),
              ),
              separatorBuilder: (context, index) => const Divider(),
            ),
          );
        },
      )),
    );
  }
}
