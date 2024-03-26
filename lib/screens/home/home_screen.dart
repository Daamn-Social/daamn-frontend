import 'package:daamn/providers/nearby_user.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:daamn/screens/profile/user_profile.dart';
import '../../constant/exports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<UserModel>? nearByUser;
  UserModel? userdata;
  @override
  void initState() {
    getCurrentUserDatadata();
    super.initState();
  }

  getCurrentUserDatadata() async {
    userdata = await context.read<GoogleSignInProvider>().getUserData();
    getdata();
  }

  getdata() async {
    final readdata = context.read<NearByUserProvider>();
    readdata.getUser(userLat: userdata!.lat, userLng: userdata!.lng);
    await Future.delayed(const Duration(seconds: 1)); // Pause for 1 second

    getdata();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final watchData = context.watch<NearByUserProvider>();
    return userdata == null
        ? Center(
            child: AvatarGlow(
              startDelay: const Duration(milliseconds: 1000),
              glowColor: Colors.white,
              glowShape: BoxShape.circle,
              curve: Curves.fastOutSlowIn,
              child: Container(
                // height: h * 0.9,
                width: w * 0.2, clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: transparent,
                    border: Border.all(color: primaryColor, width: 3)),
                child: Center(
                  child: CircleAvatar(
                    radius: w * 0.1,
                  ),
                ),
              ),
            ),
          )
        : SizedBox(
            height: h,
            width: w,
            child: watchData.nearByUser == null
                ? SizedBox(
                    height: h,
                    width: w,
                    // decoration: const BoxDecoration(
                    //     image: DecorationImage(
                    //         image: AssetImage(elipces), fit: BoxFit.fill)),
                    child: Center(
                      child: AvatarGlow(
                        startDelay: const Duration(milliseconds: 1000),
                        glowColor: Colors.white,
                        glowShape: BoxShape.circle,
                        curve: Curves.fastOutSlowIn,
                        child: Container(
                          // height: h * 0.9,
                          width: w * 0.2, clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: transparent,
                              border:
                                  Border.all(color: primaryColor, width: 3)),
                          child: Center(
                            child: CircleAvatar(
                              radius: w * 0.1,
                              backgroundImage: const AssetImage(p6),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            // height: h * 0.9,
                            width: w * 0.2, clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: transparent,
                                border:
                                    Border.all(color: primaryColor, width: 3)),
                            child: Center(
                                child: userdata != null
                                    ? userdata!.image == ""
                                        ? CircleAvatar(
                                            radius: w * 0.1,
                                            child: const Icon(
                                                Icons.person_2_outlined,
                                                size: 33),
                                          )
                                        : CircleAvatar(
                                            radius: w * 0.1,
                                            backgroundImage:
                                                NetworkImage(userdata!.image!),
                                          )
                                    : CircleAvatar(
                                        radius: w * 0.1,
                                        child: const Icon(
                                            Icons.person_2_outlined,
                                            size: 33),
                                      )),
                          ),
                        ],
                      ),
                      for (int i = 0; i < watchData.nearByUser!.length; i++)
                        Positioned(
                            top: calculatePosition(
                                    userdata!.lat,
                                    userdata!.lng,
                                    watchData.nearByUser![i].lat,
                                    watchData.nearByUser![i].lng,
                                    i)
                                .dx,
                            left: calculatePosition(
                              userdata!.lat,
                              userdata!.lng,
                              watchData.nearByUser![i].lat,
                              watchData.nearByUser![i].lng,
                              i,
                            ).dy, // getRandomSize(w),
                            child: SizedBox(
                              child: GestureDetector(
                                onTap: () {
                                  AppNavigator.to(UserProfileScreen(
                                    friendID: watchData.nearByUser![i].userId!,
                                  ));
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                          color: differentColors[i],
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: appTextGiloryBlack(
                                          textString: extractFirstName(
                                              watchData.nearByUser![i].name),
                                          fontSize: 10),
                                    ),
                                    verticalSpacer(space: 0.005),
                                    Container(
                                      // height: h * 0.9,
                                      width: w * 0.15,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: transparent,
                                          border: Border.all(
                                              color: differentColors[i],
                                              width: 3)),
                                      child: Center(
                                        child: CircleAvatar(
                                          radius: w * 0.07,
                                          backgroundImage: NetworkImage(
                                              watchData.nearByUser![i].image ??
                                                  placeHolderNetwork),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      if (watchData.nearByUser!.isEmpty) ...{
                        Positioned(
                            top: h * 0.6,
                            child: SizedBox(
                                width: w,
                                child: Center(
                                    child: appTextGiloryBlack(
                                        textString: "No User Found"))))
                      }
                    ],
                  ),
          );
  }
}
