import 'package:cached_network_image/cached_network_image.dart';
import 'package:daamn/constant/exports.dart';
import 'package:flutter/material.dart';

class ImageCacheHelper {
  static final Map<String, Image> _imageCache = {};

  static Image getImage(String key) {
    return _imageCache[key]!;
  }

  static void setImage(String key, Image image) {
    _imageCache[key] = image;
  }
}

Widget appCacheNetworkImageWidget({required String imgIRL, BoxFit? imageFit}) {
  return Builder(builder: (context) {
    final String key = imgIRL;

    if (ImageCacheHelper._imageCache.containsKey(key)) {
      return ImageCacheHelper.getImage(key);
    }

    return CachedNetworkImage(
      imageUrl: imgIRL,
      fit: imageFit ?? BoxFit.cover,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          const SpinKitCircle(
        color: appWhiteColor,
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      imageBuilder: (context, imageProvider) {
        final Image image = Image(image: imageProvider, fit: BoxFit.cover);
        ImageCacheHelper.setImage(key, image);
        return image;
      },
    );
  });
}
