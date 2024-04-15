import 'package:daamn/constant/exports.dart';

Widget appLoadingContainer(
    {required double height,
    String? errorMessage,
    Color? bg,
    Color? loaderColor}) {
  return Builder(builder: (context) {
    final w = MediaQuery.of(context).size.width;
    return Container(
      width: w * 0.9,
      height: height,
      padding: const EdgeInsets.all(10),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: bg ?? Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: errorMessage != null
          ? Center(
              child: appTextGiloryBlack(
                  textString: errorMessage,
                  fontweight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 20),
            )
          : Center(
              child: SpinKitCircle(
                color: loaderColor ?? Colors.white,
              ),
            ),
    );
  });
}
