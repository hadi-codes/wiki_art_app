import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wiki_art/Api/wikiArtApi.dart';
import 'package:wiki_art/get_it.dart';

import 'Widgets/widgets.dart';

class MostViewedPage extends StatefulWidget {
  MostViewedPage({Key key}) : super(key: key);

  @override
  _MostViewedPageState createState() => _MostViewedPageState();
}

class _MostViewedPageState extends State<MostViewedPage> {
  ScrollController controller;
  MostViewedPaintings _mostViewedPaintings = MostViewedPaintings();

  final PagingController<int, Painting> _pagingController =
      PagingController(firstPageKey: 0);
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      fetchItems(pageKey);
    });
    controller = ScrollController();
    super.initState();
  }

  void fetchItems(int pageKey) async {
    await getIt<WikiArtApi>()
        .getMostViwedPaintings(mostViewedPaintings: _mostViewedPaintings)
        .then((newItems) {
      _mostViewedPaintings = newItems;
      final nextPageKey = _mostViewedPaintings.hasMore
          ? pageKey + newItems.painting.length
          : null;
      if (nextPageKey == null) {
        _pagingController.appendLastPage(
          newItems.painting,
        );
      } else {
        _pagingController.appendPage(newItems.painting, nextPageKey);
      }
    }).catchError((error) {
      print(error);
      _pagingController.error = (error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("WikiArt"),
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (controller.offset == 0)
            return true;
          else
            controller.animateTo(
              0.0,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 300),
            );
          return false;
        },
        child: PagedListView<int, Painting>.separated(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Painting>(
            itemBuilder: (context, item, index) => PaintingListItem(
              painting: item,
            ),
          ),
          separatorBuilder: (context, index) => const Divider(),
        ),
      ),
    );
  }
}
