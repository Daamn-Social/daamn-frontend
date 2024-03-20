import 'package:cached_network_image/cached_network_image.dart';
import 'package:daamn/constant/exports.dart';

Widget appCacheNetworkImageWidget({required String imgIRL}) {
  return Builder(builder: (context) {
    return CachedNetworkImage(
      imageUrl: imgIRL,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          const SpinKitCircle(
        color: Colors.white,
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  });
}
