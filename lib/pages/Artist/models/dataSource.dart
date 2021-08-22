import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wiki_art/Api/src/models/artistPainting.dart';
import 'package:wiki_art/Api/wikiArtApi.dart';

class PaintingGridDataSource extends PagingController<int, Painting> {
  PaintingGridDataSource({
    this.wikiArtApi,
    this.artistId,
  }) : super(firstPageKey: 0) {
    this.addPageRequestListener(
      (pageKey) {
        fetchItems(pageKey);
      },
    );
  }
  Object _activeCallbackIdentity;
  final WikiArtApi wikiArtApi;

  final String artistId;
  ArtistPainting _artistPainting = ArtistPainting();

  void fetchItems(int pageKey) {
    final callbackIdentity = Object();

    _activeCallbackIdentity = callbackIdentity;

    wikiArtApi
        .getArtistPaintings(artistId: artistId, artistPainting: _artistPainting)
        .then((newItems) {
      _artistPainting = newItems;
      final nextPageKey =
          _artistPainting.hasMore ? pageKey + newItems.painting.length : null;
      if (callbackIdentity == _activeCallbackIdentity) {
        appendPage(newItems.painting, nextPageKey);
      }
    }).catchError((error) {
      if (callbackIdentity == _activeCallbackIdentity) {
        error = (error);
      }
    });
  }

  @override
  void dispose() {
    _activeCallbackIdentity = null;
    super.dispose();
  }
}
