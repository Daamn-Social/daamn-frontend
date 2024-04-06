import 'package:daamn/constant/exports.dart';

class ImageWithHero extends StatelessWidget {
  final bool itsMe;
  final String imageUrl;
  final String heroTag;

  const ImageWithHero({
    super.key,
    required this.imageUrl,
    required this.heroTag,
    required this.itsMe,
  });

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Center(
                child: Hero(
                    tag: heroTag,
                    child: appCacheNetworkImageWidget(
                        imgIRL: imageUrl, imageFit: BoxFit.contain)),
              ),
            ),
          );
        }));
      },
      child: Hero(
        tag: '$heroTag-thumbnail',
        child: Container(
            height: h * 0.3,
            width: w * 0.5,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              boxShadow: customShadow,
              border: Border.all(
                  width: 3, color: itsMe ? primaryColor : appWhiteColor),
              borderRadius: BorderRadius.circular(4),
            ),
            child: imageUrl == "loading"
                ? const Center(
                    child: SpinKitCircle(color: appWhiteColor),
                  )
                : appCacheNetworkImageWidget(imgIRL: imageUrl)),
      ),
    );
  }
}
