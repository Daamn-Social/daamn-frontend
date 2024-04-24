import 'dart:math';
import 'package:daamn/screens/home/widget/avatar_glow.dart';
import 'package:daamn/screens/profile/user_profile.dart';
import 'package:daamn/screens/settings/settings.dart';
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
    userdata = await getUserData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return userdata == null
        ? avatarGlowWidget()
        : Stack(
            children: [
              Center(
                child: Container(
                  width: w * 0.2,
                  margin: EdgeInsets.only(top: h * 0.01),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: transparent,
                      border: Border.all(color: primaryColor, width: 3)),
                  child: Center(
                    child: CircleAvatar(
                      radius: w * 0.1,
                      backgroundImage:
                          NetworkImage(userdata!.image ?? placeHolderNetwork),
                    ),
                  ),
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
                  )),
              SizedBox(
                height: h,
                width: w,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where('online_Status', isEqualTo: "Online")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return avatarGlowWidget(imgURl: userdata!.image);
                    }
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }
                    List<DocumentSnapshot> users = snapshot.data!.docs
                        .where((user) =>
                            user.id != userdata!.userId &&
                            calculateDistance(userdata!.lat, userdata!.lng,
                                    user['lat'], user['lng']) <
                                1000)
                        .toList();

                    users.sort((a, b) {
                      double distanceA = calculateDistance(
                          userdata!.lat, userdata!.lng, a['lat'], a['lng']);
                      double distanceB = calculateDistance(
                          userdata!.lat, userdata!.lng, b['lat'], b['lng']);

                      return distanceA.compareTo(distanceB);
                    });

                    return users.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                verticalSpacer(space: 0.15),
                                appTextGiloryMedium(
                                    textString: "No User Available"),
                              ],
                            ),
                          )
                        : Stack(
                            children: [
                              for (int i = 0; i < users.length; i++) ...{
                                Positioned(
                                    top: getOffsetForUserPosition(
                                            getUserPosition(
                                              userdata!.lat,
                                              userdata!.lng,
                                              users[i]['lat'],
                                              users[i]['lng'],
                                            ),
                                            i)
                                        .dy,
                                    left: getOffsetForUserPosition(
                                            getUserPosition(
                                              userdata!.lat,
                                              userdata!.lng,
                                              users[i]['lat'],
                                              users[i]['lng'],
                                            ),
                                            i)
                                        .dx,
                                    child: SizedBox(
                                      child: GestureDetector(
                                        onTap: () {
                                          AppNavigator.to(UserProfileScreen(
                                            friendID: users[i].id,
                                          ));
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 2),
                                              decoration: BoxDecoration(
                                                  color: differentColors[0],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: appTextGiloryBlack(
                                                  textString: extractFirstName(
                                                      users[i]['name']),
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
                                                      color: differentColors[0],
                                                      width: 3)),
                                              child: Center(
                                                child: CircleAvatar(
                                                  radius: w * 0.07,
                                                  backgroundImage: NetworkImage(
                                                      users[i]['image'] ??
                                                          placeHolderNetwork),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                              }
                            ],
                          );
                  },
                ),
              ),
            ],
          );
  }
}

class ScreenPosition {
  final double x;
  final double y;

  ScreenPosition(this.x, this.y);
}

ScreenPosition getScreenPosition(double myLat, double myLon, double friendLat,
    double friendLon, double screenMaxX, double screenMaxY) {
  const double earthRadius = 6371000; // in meters
  const double degToRad = pi / 180.0;
  const double offset = 10.0; // Offset to avoid overlapping

  double dLat = (friendLat - myLat) * degToRad;
  double dLon = (friendLon - myLon) * degToRad;

  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(myLat * degToRad) *
          cos(friendLat * degToRad) *
          sin(dLon / 2) *
          sin(dLon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  double distance = earthRadius * c;

  double bearing = atan2(
      sin(dLon) * cos(friendLat * degToRad),
      cos(myLat * degToRad) * sin(friendLat * degToRad) -
          sin(myLat * degToRad) * cos(friendLat * degToRad) * cos(dLon));

  double angle = (bearing * 180.0 / pi + 360.0) % 360.0;

  double maxDistance = earthRadius * pi;

  double x = (distance * screenMaxX / maxDistance) * cos(angle * degToRad) +
      screenMaxX / 2;
  double y = (distance * screenMaxY / maxDistance) * sin(angle * degToRad) +
      screenMaxY / 2;

  // Check if the position overlaps with the current user
  if (x == screenMaxX / 2 && y == screenMaxY / 2) {
    x += offset; // Move the position to the right
    y += offset; // Move the position down
  }

  return ScreenPosition(x, y);
}
