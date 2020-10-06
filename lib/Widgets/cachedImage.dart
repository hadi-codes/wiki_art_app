import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wiki_art/Theme/theme.dart';

class CachedImageWidget extends StatelessWidget {
  const CachedImageWidget({Key key, this.imageUrl}) : super(key: key);
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            alignment: Alignment.topCenter,
            scale: 5,
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).accentColor),
          color: Colors.black,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      // placeholder: (context, url) => Shimmer.fromColors(
      //   baseColor: AppTheme.black,
      //   highlightColor: Colors.grey[800],
      //   enabled: true,
      //   child: Container(
      //     decoration: BoxDecoration(
      //       color: Colors.black,
      //       borderRadius: BorderRadius.circular(10.0),
      //     ),
      //   ),
      // ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
