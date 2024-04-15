import 'package:daamn/constant/exports.dart';
import 'package:badges/badges.dart' as badge;

Widget likeBadge({required String icon, required String txt}) {
  return badge.Badge(
      badgeStyle: const badge.BadgeStyle(badgeColor: transparent),
      badgeContent: Image.asset(
        icon,
        scale: 2.5,
      ),
      position: badge.BadgePosition.custom(start: 2, top: -14),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: appWhiteColor,
            gradient: primaryGradiant),
        child: Center(
          child: appTextGiloryMedium(
              textString: txt, color: Colors.white, fontSize: 16),
        ),
      ));
}
