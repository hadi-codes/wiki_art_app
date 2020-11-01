import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wiki_art/Api/wikiArtApi.dart';

class PaintingListViewDataSource extends PagedDataSource<int, Painting> {
  PaintingListViewDataSource(this.wikiArtApi) : super(0);
  Object _activeCallbackIdentity;
  final WikiArtApi wikiArtApi;
  MostViewedPaintings _mostViewedPaintings = MostViewedPaintings();
  @override
  void fetchItems(int pageKey) {
    final callbackIdentity = Object();

    _activeCallbackIdentity = callbackIdentity;

    wikiArtApi
        .getMostViwedPaintings(mostViewedPaintings: _mostViewedPaintings)
        .then((newItems) {
      _mostViewedPaintings = newItems;
      final nextPageKey = _mostViewedPaintings.hasMore
          ? pageKey + newItems.painting.length
          : null;
      if (callbackIdentity == _activeCallbackIdentity) {
        notifyNewPage(newItems.painting, nextPageKey);
      }
    }).catchError((error) {
      print(error);
      if (callbackIdentity == _activeCallbackIdentity) {
        notifyError(error);
      }
    });
  }

  @override
  void dispose() {
    _activeCallbackIdentity = null;
    super.dispose();
  }
}
