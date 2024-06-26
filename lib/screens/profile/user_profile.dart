// ignore_for_file: must_be_immutable

import 'package:daamn/constant/exports.dart';
import 'package:daamn/screens/chat/chat_screen.dart';
import 'package:daamn/screens/profile/widgets/like_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserProfileScreen extends StatefulWidget {
  final String friendID;
  const UserProfileScreen({required this.friendID, super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    getUserdata();
    super.initState();
  }

  getUserdata() async {
    DocumentSnapshot<Map<String, dynamic>>? user = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(widget.friendID)
        .get();

    userData = user.data();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: appBlackColor,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ellipseSetting), fit: BoxFit.cover),
          ),
          child: Center(
            child: SizedBox(
              height: h,
              width: w * 0.9,
              child: userData == null
                  ? appLoadingContainer(height: h)
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: w * 0.5,
                                height: h * 0.3,
                                child: Stack(
                                  children: [
                                    Container(
                                      width: w * 0.5,
                                      height: h * 0.3,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        boxShadow: customShadow,
                                        border: Border.all(color: primaryColor),
                                      ),
                                      child: userData!['image'] == null
                                          ? const Icon(Icons.account_circle)
                                          : appCacheNetworkImageWidget(
                                              imgIRL: userData!['image'],
                                            ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      left: 10,
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundColor: appWhiteColor,
                                        child: Center(
                                          child: IconButton(
                                              onPressed: () {
                                                AppNavigator.off();
                                              },
                                              icon: const Icon(
                                                Icons.arrow_back_ios,
                                                size: 15,
                                              )),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: w * 0.4,
                                height: h * 0.3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    verticalSpacer(space: 0.07),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        likeBadge(
                                            icon: 'assets/icon/hand.png',
                                            txt: "85%"),
                                        horizontalSpacer(space: 0.03),
                                        likeBadge(
                                            icon: 'assets/icon/star.png',
                                            txt: "23k"),
                                      ],
                                    ),
                                    verticalSpacer(space: 0.02),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        likeBadge(
                                            icon: 'assets/icon/eyes.png',
                                            txt: "5k"),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          verticalSpacer(space: 0.02),
                          SizedBox(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    appTextGiloryBlack(
                                        textString: userData!['name'],
                                        fontSize: 22,
                                        fontweight: FontWeight.w400),
                                    appTextGiloryMedium(
                                        textString:
                                            "Glowed on ${userData!['join_date'].toDate().toString().substring(0, 10)}",
                                        fontSize: 12,
                                        fontweight: FontWeight.w400),
                                  ],
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    AppNavigator.to(ChatScreen(
                                      userID: userData!['userId'],
                                      userName: userData!['name'],
                                      userImage: userData!['image'] ?? "",
                                    ));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        gradient: primaryGradiant,
                                        shape: BoxShape.circle),
                                    width: 50,
                                    child: Center(
                                      child: ImageIcon(
                                        AssetImage(
                                          messageicon,
                                        ),
                                        color: appWhiteColor,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          appDivider(),
                          userData!['userBio'] == ''
                              ? SizedBox(
                                  width: w,
                                  height: 50,
                                  child: Center(
                                    child: appTextGiloryMedium(
                                        textString: "Not  Available"),
                                  ),
                                )
                              : appTextGiloryMedium(
                                  isCenter: false,
                                  textString: userData!['userBio'],
                                  fontSize: 16,
                                  fontweight: FontWeight.w400),
                          appDivider(),
                          appTextGiloryBlack(
                              textString:
                                  '${extractFirstName(userData!['name'])} is interested in',
                              fontSize: 18,
                              fontweight: FontWeight.w400),
                          verticalSpacer(space: 0.01),
                          userData!['interests'].isEmpty
                              ? SizedBox(
                                  width: w,
                                  height: 50,
                                  child: Center(
                                    child: appTextGiloryMedium(
                                        textString: "Not  Available"),
                                  ),
                                )
                              : SizedBox(
                                  width: w,
                                  child: Wrap(
                                    spacing:
                                        8.0, // spacing between each interest
                                    runSpacing:
                                        8.0, // spacing between rows of interests
                                    children: List.generate(
                                      userData!['interests'].length,
                                      (index) => Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 12),
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          gradient: primaryGradiant,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: appTextGiloryBlack(
                                          textString: userData!['interests']
                                              [index],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          appDivider(),
                          Row(
                            children: [
                              appTextGiloryBlack(
                                  textString:
                                      extractFirstName(userData!['name']),
                                  fontSize: 18,
                                  fontweight: FontWeight.w400),
                              appTextGiloryBlack(
                                  textString: ' Daamn ',
                                  fontSize: 18,
                                  color: primaryColor,
                                  fontweight: FontWeight.w400),
                              appTextGiloryBlack(
                                  textString: 'Looking Pictures ',
                                  fontSize: 18,
                                  fontweight: FontWeight.w400),
                            ],
                          ),
                          verticalSpacer(space: 0.01),
                          userData!['imagesList'].isEmpty
                              ? SizedBox(
                                  width: w,
                                  height: 50,
                                  child: Center(
                                    child: appTextGiloryMedium(
                                        textString: "No image"),
                                  ),
                                )
                              : SizedBox(
                                  width: w,
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    spacing:
                                        8.0, // spacing between each interest
                                    runSpacing:
                                        8.0, // spacing between rows of interests
                                    children: List.generate(
                                      userData!['imagesList'].length,
                                      (index) => Container(
                                        width: w * 0.28,
                                        height: h * 0.15,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                            gradient: primaryGradiant,
                                            boxShadow: customShadow,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    userData!['imagesList']
                                                        [index]),
                                                fit: BoxFit.cover),
                                            color:
                                                primaryColor.withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: primaryColor)),
                                        // child: appCacheNetworkImageWidget(
                                        //   imgIRL: userData!['imagesList']
                                        //       [index],
                                        // ),
                                      ),
                                    ),
                                  ),
                                ),
                          verticalSpacer(space: 0.01),
                          appDivider(),
                          appTextGiloryBlack(
                              textString:
                                  '${extractFirstName(userData!['name'])} is on',
                              fontSize: 18,
                              fontweight: FontWeight.w400),
                          verticalSpacer(space: 0.01),
                          Wrap(
                            children: [
                              for (int i = 0; i < socialIcons.length; i++) ...{
                                if (userData!['social_links'].contains(i)) ...{
                                  GestureDetector(
                                    onTap: () {},
                                    child: Card(
                                      clipBehavior: Clip.antiAlias,
                                      color: Colors.white,
                                      child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: Center(
                                              child: SizedBox(
                                                  width: 28,
                                                  child: Image.asset(
                                                      socialIcons[i]
                                                          .imagePath)))),
                                    ),
                                  ),
                                }
                              }
                            ],
                          ),
                          verticalSpacer(space: 0.01),
                          appDivider(),
                          verticalSpacer(space: 0.15),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget socialicon({required String icon, void Function()? ontap}) {
  return InkWell(
    onTap: ontap,
    child: Container(
        width: 60,
        height: 60,
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: primaryColor)),
        child: Center(
          child: Image.asset(icon),
        )),
  );
}
