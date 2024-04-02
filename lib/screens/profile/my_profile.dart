// ignore_for_file: must_be_immutable

import 'package:daamn/constant/exports.dart';
import 'package:daamn/providers/streams_provider.dart';
import 'package:daamn/screens/profile/widgets/add_social_media.dart';
import 'package:daamn/screens/profile/widgets/interest_dialoge.dart';
import 'package:daamn/screens/profile/widgets/user_image_list.dart';
import 'package:daamn/screens/profile/widgets/user_profile_dialoge.dart';
import 'package:daamn/screens/settings/settings.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData;
  @override
  void initState() {
    super.initState();
    initalizeStream();
  }

  initalizeStream() {
    Provider.of<DataStreamProvider>(context, listen: false)
        .initializeCurrenTuserStream();
    print("initaizing userDataSream");
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Center(
      child: Consumer<DataStreamProvider>(
          builder: (context, DataStreamProvider, _) {
        return Container(
          decoration: const BoxDecoration(
            color: appBlackColor,
            image: DecorationImage(
                image: AssetImage(ellipseSetting), fit: BoxFit.cover),
          ),
          // height: h,
          // width: w,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: StreamBuilder<DocumentSnapshot>(
            stream: DataStreamProvider.currentUserStream,
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return appLoadingContainer(height: h);
              }
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              DocumentSnapshot<Object?>? userData = snapshot.data;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: w,
                      height: h * 0.3,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                      ),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: w,
                            height: h * 0.3,
                            child: userData!['image'] == null
                                ? const Icon(Icons.account_circle)
                                : appCacheNetworkImageWidget(
                                    imgIRL: userData['image'],
                                  ),
                          ),
                          Positioned(
                              top: 10,
                              right: 10,
                              child: GestureDetector(
                                onTap: () {
                                  AppNavigator.to(const SettingsScreen());
                                },
                                child: const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: ImageIcon(AssetImage(nav1)),
                                ),
                              ))
                        ],
                      ),
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
                              SizedBox(
                                width: w * 0.9,
                                child: Row(
                                  children: [
                                    appTextGiloryBlack(
                                        textString: userData['name'],
                                        fontSize: 22,
                                        fontweight: FontWeight.w400),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return UserprofileDialoge(
                                                name: userData['name'],
                                                bio: userData['userBio'],
                                                img: userData['image'],
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: appWhiteColor,
                                        ))
                                  ],
                                ),
                              ),
                              appTextGiloryMedium(
                                  textString:
                                      "Glowed on ${userData['join_date'].toDate().toString().substring(0, 10)}",
                                  fontSize: 12,
                                  fontweight: FontWeight.w400),
                            ],
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    appDivider(),
                    userData['userBio'] == ''
                        ? SizedBox(
                            width: w,
                            height: 50,
                            child: Center(
                              child: appTextGiloryMedium(textString: "Add Bio"),
                            ),
                          )
                        : appTextGiloryMedium(
                            isCenter: false,
                            textString: userData['userBio'],
                            fontSize: 16,
                            fontweight: FontWeight.w400),
                    appDivider(),
                    Row(
                      children: [
                        appTextGiloryBlack(
                            textString:
                                '${extractFirstName(userData['name'])} is interested in',
                            fontSize: 18,
                            fontweight: FontWeight.w400),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return UserInterestDialoge(
                                    interest: userData['interests'],
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.add,
                              color: appWhiteColor,
                            ))
                      ],
                    ),
                    verticalSpacer(space: 0.01),
                    userData['interests'].isEmpty
                        ? SizedBox(
                            width: w,
                            height: 50,
                            child: Center(
                              child: appTextGiloryMedium(
                                  textString: "Add Your interest"),
                            ),
                          )
                        : SizedBox(
                            width: w,
                            child: Wrap(
                              spacing: 8.0, // spacing between each interest
                              runSpacing:
                                  8.0, // spacing between rows of interests
                              children: List.generate(
                                userData['interests'].length,
                                (index) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    gradient: primaryGradiant,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: appTextGiloryBlack(
                                    textString:
                                        userData['interests'][index].toString(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                    appDivider(),
                    Row(
                      children: [
                        SizedBox(
                          width: w * 0.75,
                          child: Wrap(
                            children: [
                              appTextGiloryBlack(
                                  textString:
                                      extractFirstName(userData['name']),
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
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return UserImageList(
                                    images: userData['imagesList'],
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.add,
                              color: appWhiteColor,
                            ))
                      ],
                    ),
                    verticalSpacer(space: 0.01),
                    userData['imagesList'].isEmpty
                        ? SizedBox(
                            width: w,
                            height: 50,
                            child: Center(
                              child: appTextGiloryMedium(
                                  textString: "No image found"),
                            ),
                          )
                        : SizedBox(
                            width: w,
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 8.0, // spacing between each interest
                              runSpacing:
                                  8.0, // spacing between rows of interests
                              children: List.generate(
                                userData['imagesList'].length,
                                (index) => Container(
                                  width: w * 0.28,
                                  height: h * 0.15,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      gradient: primaryGradiant,
                                      boxShadow: customShadow,
                                      color: primaryColor.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              userData['imagesList'][index]),
                                          fit: BoxFit.cover),
                                      border: Border.all(color: primaryColor)),
                                  // child: appCacheNetworkImageWidget(
                                  //   imgIRL: userData['imagesList'][index],
                                  // ),
                                ),
                              ),
                            ),
                          ),
                    verticalSpacer(space: 0.01),
                    appDivider(),
                    Row(
                      children: [
                        appTextGiloryBlack(
                            textString:
                                '${extractFirstName(userData['name'])} is on',
                            fontSize: 18,
                            fontweight: FontWeight.w400),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SocialMediaDialoge(
                                    selected: userData['social_links'],
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.add,
                              color: appWhiteColor,
                            ))
                      ],
                    ),
                    verticalSpacer(space: 0.01),
                    Wrap(
                      children: [
                        for (int i = 0; i < socialIcons.length; i++) ...{
                          if (userData['social_links'].contains(i)) ...{
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
                                                socialIcons[i].imagePath)))),
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
              );
            },
          ),
        );
      }),
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
