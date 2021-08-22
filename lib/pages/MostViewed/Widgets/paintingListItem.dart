import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:overlay_dialog/overlay_dialog.dart';
import 'package:wiki_art/Api/wikiArtApi.dart';
import 'package:wiki_art/Widgets/widget.dart';

import '../../pages.dart';

class PaintingListItem extends StatefulWidget {
  const PaintingListItem({
    @required this.painting,
    Key key,
  })  : assert(painting != null),
        super(key: key);

  final Painting painting;

  @override
  _PaintingListItemState createState() => _PaintingListItemState();
}

class _PaintingListItemState extends State<PaintingListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          _Painting(
            painting: widget.painting,
          ),
          _Details(
            painting: widget.painting,
          ),
        ],
      ),
    );
  }
}

class _Details extends StatelessWidget {
  const _Details({Key key, this.painting}) : super(key: key);
  final Painting painting;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).accentColor,
      ),
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: new TextSpan(
            text: "${painting.title} \n",
            style: Theme.of(context)
                .textTheme
                .headline5
                .apply(fontSizeFactor: painting.title.length > 25 ? 0.75 : 1),
            children: <TextSpan>[
              new TextSpan(
                text: "${painting.artistName ?? "unknown"} \n",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              new TextSpan(
                text: "${painting.completitionYear}",
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Painting extends StatelessWidget {
  const _Painting({Key key, this.painting}) : super(key: key);
  final Painting painting;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _showCustom(context, painting),
      onDoubleTap: () => print("Save"),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SlidePage(
            painting: painting,
          ),
        ),
      ),
      child: Hero(
        tag: painting.image,
        child: Container(
          height: 400,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          child: CachedImageWidget(
            imageUrl: painting.image,
          ),
        ),
      ),
    );
  }
}

void _showCustom(BuildContext context, Painting painting) {
  DialogHelper().show(
    context,
    DialogWidget.custom(
      closable: true,
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            border: Border.all(
              color: Theme.of(context).accentColor,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Option",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Divider(),
              FlatButton(
                child: Text(
                  "Save",
                  style: Theme.of(context).textTheme.headline6,
                ),
                onPressed: () => print("Save"),
              ),
              Divider(),
              FlatButton(
                child: Text(
                  "View Artis",
                  style: Theme.of(context).textTheme.headline6,
                ),
                onPressed: () {
                  DialogHelper().hide(context);
                  Navigator.push(
                    context,
                    ArtistPage.route(painting),
                  );
                },
              )
            ],
          ),
        ),
      ),
    ),
  );
}
