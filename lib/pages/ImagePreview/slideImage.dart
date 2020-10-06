import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wiki_art/Api/src/models/painting.dart';

class SlidePage extends StatefulWidget {
  const SlidePage({this.painting});
  final Painting painting;
  @override
  _SlidePageState createState() => _SlidePageState();
}

class _SlidePageState extends State<SlidePage> {
  bool _isDetailsVisible = true;
  GlobalKey<ExtendedImageSlidePageState> slidePagekey =
      GlobalKey<ExtendedImageSlidePageState>();
  void _showHideDetials() {
    _isDetailsVisible = !_isDetailsVisible;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
          tag: widget.painting.image,
          child: GestureDetector(
            onTap: () => _showHideDetials(),
            child: Stack(children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: double.infinity,
                  child: ExtendedImage.network(
                    widget.painting.image,
                    enableSlideOutPage: true,
                    mode: ExtendedImageMode.gesture,
                    heroBuilderForSlidingPage: (Widget result) {
                      return Hero(
                        tag: widget.painting.image,
                        child: result,
                        flightShuttleBuilder: (BuildContext flightContext,
                            Animation<double> animation,
                            HeroFlightDirection flightDirection,
                            BuildContext fromHeroContext,
                            BuildContext toHeroContext) {
                          final Hero hero =
                              (flightDirection == HeroFlightDirection.pop
                                  ? fromHeroContext.widget
                                  : toHeroContext.widget) as Hero;
                          return hero.child;
                        },
                      );
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: _isDetailsVisible
                    ? Container(
                        color: Colors.grey.withOpacity(0.3),
                        padding: const EdgeInsets.all(10.0),
                        height: widget.painting.title.length < 25 ? 75 : 110,
                        width: double.infinity,
                        child: Column(
                          children: [
                            Text(
                              widget.painting.title,
                              style: Theme.of(context).textTheme.headline6,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                widget.painting.completitionYear,
                                style: Theme.of(context).textTheme.subtitle1,
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ))
                    : SizedBox(),
              ),
            ]),
          )),
      //   child: ExtendedImageSlidePage(
      //     key: slidePagekey,
      //     child:
      //     ),
      //     slideAxis: SlideAxis.both,
      //     slideType: SlideType.onlyImage,
      //   ),
    );
  }
}
