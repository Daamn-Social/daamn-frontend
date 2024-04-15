import 'package:daamn/constant/exports.dart';
import 'package:daamn/screens/profile/user_profile.dart';
import 'package:daamn/services/firebase.dart';

class CustomBottomSheet extends StatelessWidget {
  final String userID;
  final String userName;
  final String userImage;

  const CustomBottomSheet(
      {required this.userImage,
      required this.userID,
      required this.userName,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: primaryColor,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff400099), Color(0xff150033)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(userImage),
                backgroundColor: appWhiteColor,
                radius: 25,
                // child: appCacheNetworkImageWidget(imgIRL: userImage),
              ),
              horizontalSpacer(space: 0.02),
              appTextGiloryBlack(textString: userName, fontSize: 18),
              const Spacer(),
              CircleAvatar(
                backgroundColor: appWhiteColor,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
                color: appWhiteColor, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tilles(txt: "Mute chat"),
                appDivider(),
                tilles(
                  txt: 'View Profile',
                  ontap: () {
                    AppNavigator.toReplacement(UserProfileScreen(
                      friendID: userID,
                    ));
                  },
                ),
                appDivider(),
                tilles(
                  txt: 'Pin Chat',
                  ontap: () {},
                ),
                appDivider(),
                tilles(
                  txt: 'Clear Chat',
                  ontap: () {
                    AppNavigator.off();
                    clearOneToOneCollection(userID);
                  },
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
                color: appWhiteColor, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tilles(
                  txt: "Delete",
                  textColo: Colors.redAccent,
                  ontap: () {
                    AppNavigator.off();
                    deleteChat(userID);
                  },
                ),
                appDivider(colr: Colors.redAccent),
                tilles(
                  txt: 'Block ${extractFirstName(userName)}',
                  textColo: Colors.redAccent,
                  ontap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget tilles({required String txt, void Function()? ontap, Color? textColo}) {
  return GestureDetector(
    onTap: ontap,
    child: appTextGiloryMedium(
        textString: txt,
        fontSize: 16,
        isCenter: false,
        color: textColo ?? Colors.black,
        fontweight: FontWeight.w600),
  );
}
