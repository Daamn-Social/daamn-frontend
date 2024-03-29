import 'package:avatar_glow/avatar_glow.dart';
import 'package:daamn/constant/exports.dart';

Widget avatarGlowWidget({String? imgURl}) {
  return Builder(builder: (context) {
    // final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Center(
      child: AvatarGlow(
        startDelay: const Duration(milliseconds: 1000),
        glowColor: Colors.white,
        glowShape: BoxShape.circle,
        curve: Curves.fastOutSlowIn,
        child: Container(
          width: w * 0.2,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: transparent,
              border: Border.all(color: primaryColor, width: 3)),
          child: Center(
            child: CircleAvatar(
              radius: w * 0.1,
              backgroundImage: NetworkImage(imgURl ?? placeHolderNetwork),
            ),
          ),
        ),
      ),
    );
  });
}
