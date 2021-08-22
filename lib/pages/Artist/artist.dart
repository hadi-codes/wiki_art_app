import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:peek_and_pop_dialog/peek_and_pop_dialog.dart';
import 'package:wiki_art/Api/src/models/artistDetails.dart';
import 'package:wiki_art/Api/wikiArtApi.dart';
import 'package:wiki_art/Widgets/widget.dart';
import 'package:wiki_art/get_it.dart';
import 'package:wiki_art/pages/pages.dart';

import 'models/dataSource.dart';

class ArtistPage extends StatefulWidget {
  const ArtistPage({Key key, @required this.painting}) : super(key: key);
  final Painting painting;

  static CupertinoPageRoute route(Painting painting) => CupertinoPageRoute(
        builder: (context) => ArtistPage(painting: painting),
      );

  @override
  _ArtistPageState createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.painting.artistName ?? "uknown"),
        ),
        body: FutureBuilder(
          future:
              getIt<WikiArtApi>().getArtistDetails(widget.painting.artistUrl),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              ArtistDetails _artistDetails = snapshot.data;
              return Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: _ProfileWidget(
                          artistDetails: _artistDetails,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          child: Text(
                            "Art Work",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.all(10.0),
                        sliver: PagedSliverGrid<int, Painting>(
                          pagingController: PaintingGridDataSource(
                            wikiArtApi: getIt<WikiArtApi>(),
                            artistId: widget.painting.artistId,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 100 / 150,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 3,
                          ),
                          builderDelegate: PagedChildBuilderDelegate<Painting>(
                              itemBuilder: (context, item, index) =>
                                  ArtistPaintingGridItem(
                                    painting: item,
                                  )),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else
              return Center(
                child: CircularProgressIndicator(),
              );
          },
        ));
  }
}

class _ProfileWidget extends StatelessWidget {
  const _ProfileWidget({Key key, this.artistDetails}) : super(key: key);
  final ArtistDetails artistDetails;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            height: 85,
            width: 85,
            child: Center(
              child: CachedImageWidget(
                imageUrl: artistDetails.getImage,
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(artistDetails.artistName),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    width: 200,
                    child: Text(
                      "${artistDetails.birthDayAsString} - ${artistDetails.deathDayAsString}",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ArtistPaintingGridItem extends StatelessWidget {
  const ArtistPaintingGridItem({
    @required this.painting,
    Key key,
  })  : assert(painting != null),
        super(key: key);
  final Painting painting;

  @override
  Widget build(BuildContext context) {
    return PeekAndPopDialog(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SlidePage(
                    painting: painting,
                  )));
        },
        child: Hero(
          tag: "${painting.image}",
          child: CachedImageWidget(
            imageUrl: painting.image,
          ),
        ),
      ),
      dialog: Align(
        alignment: Alignment.center,
        child: Container(
          height: 300,
          width: 300,
          child: CachedImageWidget(
            imageUrl: painting.image,
          ),
        ),
      ),
    );
  }
}
/*
 // 
 */
