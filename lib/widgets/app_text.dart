import 'package:daamn/constant/exports.dart';

Widget appTextGiloryBlack({
  required String textString,
  double? fontSize,
  bool isCenter = true,
  FontWeight? fontweight,
  Color? color,
  TextStyle? style,
}) {
  return Builder(builder: (context) {
    return Text(
      textString,
      textAlign: isCenter ? TextAlign.center : TextAlign.left,
      style: style ??
          TextStyle(
              color: color ?? Colors.white,
              fontFamily: "GilroyBlack",
              fontWeight: fontweight ?? FontWeight.normal,
              fontSize: fontSize ?? 12),
    );
  });
}

Widget appTextGiloryMedium({
  required String textString,
  double? fontSize,
  bool isCenter = true,
  FontWeight? fontweight,
  Color? color,
  TextStyle? style,
}) {
  return Builder(builder: (context) {
    return Text(
      textString,
      textAlign: isCenter ? TextAlign.center : TextAlign.left,
      style: style ??
          TextStyle(
              color: color ?? Colors.white,
              fontFamily: "GilroyMedium",
              fontWeight: fontweight ?? FontWeight.normal,
              fontSize: fontSize ?? 12),
    );
  });
}
