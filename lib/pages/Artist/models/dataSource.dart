import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wiki_art/Api/src/models/artist.dart';
import 'package:wiki_art/Api/src/models/artistPainting.dart';
import 'package:wiki_art/Api/wikiArtApi.dart';

class PaintingGridDataSource extends PagedDataSource<int, Painting> {
  PaintingGridDataSource({
    this.wikiArtApi,
    this.artistId,
  }) : super(0);
  Object _activeCallbackIdentity;
  final WikiArtApi wikiArtApi;

  final String artistId;
  ArtistPainting _artistPainting = ArtistPainting();
  @override
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
        notifyNewPage(newItems.painting, nextPageKey);
      }
    }).catchError((error) {
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
