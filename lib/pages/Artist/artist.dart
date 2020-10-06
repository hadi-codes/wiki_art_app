import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wiki_art/Api/cubit/wiki_art_api_cubit.dart';
import 'package:wiki_art/Api/src/models/artistDetails.dart';
import 'package:wiki_art/Api/wikiArtApi.dart';
import 'package:wiki_art/Widgets/widget.dart';

import '../pages.dart';
import 'cubit/image_dialog_cubit.dart';
import 'models/dataSource.dart';

class ArtistPage extends StatefulWidget {
  const ArtistPage({Key key, @required this.painting}) : super(key: key);
  final Painting painting;

  @override
  _ArtistPageState createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  WikiArtApi wikiArtApi = WikiArtApi();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageDialogCubit(false),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.painting.artistName ?? "uknown"),
        ),
        body: BlocBuilder<WikiArtApiCubit, WikiArtApiState>(
            builder: (context, state) {
          var dataSource = PaintingGridDataSource(
              wikiArtApi: state.wikiArtApi, artistId: widget.painting.artistId);

          return FutureBuilder(
            future: wikiArtApi.getArtistDetails(widget.painting.artistUrl),
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
                            dataSource: dataSource,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 100 / 150,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 3,
                            ),
                            builderDelegate:
                                PagedChildBuilderDelegate<Painting>(
                                    itemBuilder: (context, item, index) =>
                                        ArtistPaintingGridItem(
                                          painting: item,
                                        )),
                          ),
                        ),
                      ],
                    ),
                    _ImageDialog()
                  ],
                );
              } else
                return Center(
                  child: CircularProgressIndicator(),
                );
            },
          );
        }),
      ),
    );
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
          Padding(
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
  Widget build(BuildContext context) =>
      BlocBuilder<ImageDialogCubit, ImageDialogState>(
        builder: (context, state) {
          var bloc = context.bloc<ImageDialogCubit>();

          return GestureDetector(
              onLongPressStart: (d) => bloc.show(painting),
              onLongPressEnd: (d) => bloc.hide(),
              child: Container(
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Hero(
                    tag: painting.image,
                    child: CachedImageWidget(
                      imageUrl: painting.image,
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SlidePage(
                          painting: painting,
                        )));
              });
        },
      );
}

class _ImageDialog extends StatelessWidget {
  const _ImageDialog({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageDialogCubit, ImageDialogState>(
      builder: (context, state) {
        Size size = MediaQuery.of(context).size;
        if (state.isVisble) {
          return Container(
            height: size.height,
            width: size.width,
            child: ClipRRect(
              child: Stack(
                children: <Widget>[
                  BackdropFilter(
                    child: Container(
                      color: Colors.black12,
                    ),
                    filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                  ),
                  Center(
                    child: Container(
                      height: 340,
                      width: size.width - 80,
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                state.painting.title,
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 300,
                            child: CachedNetworkImage(
                              imageUrl: state.painting.image,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    alignment: Alignment.topCenter,
                                    scale: 5,
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else
          return SizedBox();
      },
    );
  }
}
