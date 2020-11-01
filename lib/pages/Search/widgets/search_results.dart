import 'package:flutter/material.dart';
import 'package:wiki_art/Api/src/models/painting.dart';
import 'package:wiki_art/Widgets/cachedImage.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({
    Key key,
    this.onTap,
    this.paintings = const <Painting>[],
  }) : super(key: key);

  final ValueSetter<Painting> onTap;
  final List<Painting> paintings;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    if (paintings.isEmpty)
      return SliverToBoxAdapter(
        child: Center(
          child: Text(
            'No resulte found',
            style: textTheme.headline6,
          ),
        ),
      );
    return SliverList(
        delegate: SliverChildListDelegate(
      List.generate(
          paintings.length,
          (index) => _SearchResult(
                painting: paintings[index],
                onTap: () => onTap(paintings[index]),
              )),
    ));
    // ListView.separated(
    //   separatorBuilder: (context, index) => Divider(),
    //   shrinkWrap: true,
    //   itemCount: paintings.length,
    //   itemBuilder: (context, index) => ,
    // );
  }
}

class _SearchResult extends StatelessWidget {
  const _SearchResult({
    Key key,
    this.painting,
    this.onTap,
  }) : super(key: key);

  final Painting painting;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        height: 100,
        child: Row(
          children: [
            SizedBox(
              height: 100,
              width: 75,
              child: CachedImageWidget(
                imageUrl: painting.image,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Flexible(
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: painting.title + '\n \n', style: textTheme.bodyText1),
                TextSpan(
                    text: painting.artistName,
                    style: textTheme.subtitle2
                        .apply(color: Theme.of(context).accentColor)),
              ])),
            )
          ],
        ),
      ),
    );
  }
}
