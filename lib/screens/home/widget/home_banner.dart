import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../constant/exports.dart';

class HomeBannerWidget extends StatefulWidget {
  final List<dynamic> bannerImageList;
  const HomeBannerWidget({required this.bannerImageList, super.key});

  @override
  State<HomeBannerWidget> createState() => _HomeBannerWidgetState();
}

class _HomeBannerWidgetState extends State<HomeBannerWidget> {
  int bannerIndex = 0;
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return SizedBox(
      height: h * 0.3,
      width: w,
      child: CarouselSlider.builder(
        itemCount: widget.bannerImageList.length,
        options: CarouselOptions(
          height: 400,
          aspectRatio: 16 / 9,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          autoPlayAnimationDuration: const Duration(seconds: 3),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          onPageChanged: (index, reason) {
            setState(() {
              bannerIndex = index;
            });
          },
          scrollDirection: Axis.horizontal,
        ),
        itemBuilder: (context, index, realIndex) {
          return Container(
            width: w,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: CachedNetworkImage(
              height: h * 0.2,
              width: w,
              fit: BoxFit.fill,
              imageUrl: widget.bannerImageList[index],
              progressIndicatorBuilder: (context, url, downloadProgress) {
                return const SpinKitCircle(
                  color: appWhiteColor,
                );
              },
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          );
        },
      ),
    );
  }
}
