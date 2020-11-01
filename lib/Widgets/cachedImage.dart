import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CachedImageWidget extends StatelessWidget {
  const CachedImageWidget({
    Key key,
    this.imageUrl,
  }) : super(key: key);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(imageUrl,
        shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(10),
        loadStateChanged: (ExtendedImageState state) {
      switch (state.extendedImageLoadState) {
        case LoadState.loading:
          return Container(
              decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Theme.of(context).accentColor),
            color: Colors.black,
          ));
          break;
        case LoadState.completed:
          return ExtendedRawImage(
            scale: 5,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            image: state.extendedImageInfo?.image,
          );
          break;
        case LoadState.failed:
          return Icon(Icons.error);
          break;
        default:
          return Container(
              decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Theme.of(context).accentColor),
            color: Colors.black,
          ));
          break;
      }
    });
  }
}
