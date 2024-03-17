import 'package:daamn/constant/exports.dart';
import 'package:daamn/providers/google_login_provider.dart';
import 'package:daamn/widgets/app_loading_container.dart';
import 'package:daamn/widgets/cache_image.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? userdata;
  @override
  void initState() {
    getUserdata();
    super.initState();
  }

  getUserdata() async {
    userdata = await context.read<GoogleSignInProvider>().getUserData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Center(
      child: SizedBox(
        height: h,
        width: w * 0.9,
        child: userdata == null
            ? appLoadingContainer(height: h)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  verticalSpacer(space: 0.04),
                  Row(
                    children: [
                      appText(
                          textString: 'Profile',
                          fontSize: 42,
                          fontweight: FontWeight.w400),
                    ],
                  ),
                  Container(
                    width: w * 0.4,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: appCacheNetworkImageWidget(imgIRL: userdata!.image!),
                  ),
                  verticalSpacer(space: 0.02),
                  appText(
                      textString: userdata!.name,
                      fontSize: 14,
                      fontweight: FontWeight.w400),
                  appText(
                      textString: userdata!.email,
                      fontSize: 14,
                      fontweight: FontWeight.w400),
                  appText(
                      textString: userdata!.addres,
                      fontSize: 14,
                      fontweight: FontWeight.w400),
                ],
              ),
      ),
    );
  }
}
