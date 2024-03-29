import 'package:daamn/constant/exports.dart';

Widget chatHeader(
    {required String img, required String name, required String status}) {
  return SizedBox(
    child: Row(
      children: [
        horizontalSpacer(space: 0.02),
        IconButton(
            onPressed: () {
              AppNavigator.off();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: appWhiteColor,
            )),
        CircleAvatar(
          backgroundImage:
              NetworkImage(img != '' ? img : 'https://via.placeholder.com/150'),
        ),
        horizontalSpacer(space: 0.02),
        appTextGiloryBlack(textString: name, isCenter: false),
      ],
    ),
  );
}
