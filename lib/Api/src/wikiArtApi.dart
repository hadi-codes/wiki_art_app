import 'package:dio/dio.dart';
import 'package:wiki_art/Api/src/models/artistDetails.dart';
import 'package:wiki_art/Api/src/models/artistDictionary.dart';
import 'package:wiki_art/Api/src/models/painting.dart';
import 'package:wiki_art/Api/src/models/paintingDetails.dart';
import 'models/artist.dart';
import 'models/artistPainting.dart';
import 'models/mostViewedPaintings.dart';

String v2ApiUrl = "https://www.wikiart.org/en/api/2";
String v1ApiUrl = "http://www.wikiart.org/en/";

class WikiArtApi {
  WikiArtApi();
  Dio v2 = new Dio(BaseOptions(baseUrl: v2ApiUrl));
  Dio v1 = new Dio(BaseOptions(baseUrl: v1ApiUrl));

  Future<MostViewedPaintings> getMostViwedPaintings(
      {MostViewedPaintings mostViewedPaintings}) async {
    Response response;

    if (mostViewedPaintings.paginationToken == null)
      response = await v2.get("/MostViewedPaintings");
    else if (mostViewedPaintings.hasMore == true &&
        mostViewedPaintings.paginationToken != null)
      response = await v2.get(
          "/MostViewedPaintings?paginationToken=${mostViewedPaintings.paginationToken}");

    mostViewedPaintings = mostViewedPaintingsFromJson(response.toString());
    return mostViewedPaintings;
  }

  Future<PaintingDetails> getPaintingDetails(Painting painting) async {
    Response response = await v2.get("/Painting?id=${painting.id}");

    PaintingDetails _paintingDetails =
        paintingDetailsFromJson(response.toString());
    return _paintingDetails;
  }

  Future<ArtistDetails> getArtistDetails(String artistUrl) async {
    Response response = await v1.get("/$artistUrl?json=2");
    return artistDetailsFromJson(response.toString());
  }

  Future<ArtistPainting> getArtistPaintings(
      {String artistId, ArtistPainting artistPainting}) async {
    Response response;
    if (artistPainting.paginationToken == null)
      response = await v2.get("/PaintingsByArtist?id=$artistId");
    else if (artistPainting.hasMore == true &&
        artistPainting.paginationToken != null)
      response = await v2.get(
          "/PaintingsByArtist?id=$artistId&paginationToken=${artistPainting.paginationToken}");

    return artistPaintingFromJson(response.toString());
  }
}
