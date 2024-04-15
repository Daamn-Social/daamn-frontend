import '../../constant/exports.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: scafoldBg,
      body: Container(
        height: h,
        width: w,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(splashImg), fit: BoxFit.cover)),
        child: Column(
          children: [
            verticalSpacer(space: 0.05),
            const Spacer(),
            Center(
              child: Builder(builder: (context) {
                return InkWell(
                  onTap: () async {
                    await Provider.of<GoogleSignInProvider>(context,
                            listen: false)
                        .googleLogin(context: context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: w * 0.8,
                    decoration: BoxDecoration(
                        color: appWhiteColor,
                        borderRadius: BorderRadius.circular(25)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            child: Image.asset(
                          googleLogo,
                          scale: 18,
                        )),
                        appTextGiloryMedium(
                            textString: "  Continue with google",
                            color: appBlackColor,
                            fontSize: 18,
                            fontweight: FontWeight.w600),
                      ],
                    ),
                  ),
                );
              }),
            ),
            verticalSpacer(space: 0.06),
          ],
        ),
      ),
    );
  }
}

profileItemWidget(
    {required String name,
    required profile,
    required Color clr,
    required double wid,
    required double higth}) {
  return Builder(builder: (context) {
//final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Positioned(
        top: higth,
        left: wid,
        child: SizedBox(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                    color: clr, borderRadius: BorderRadius.circular(12)),
                child: appTextGiloryBlack(textString: name),
              ),
              verticalSpacer(space: 0.005),
              Container(
                // height: h * 0.9,
                width: w * 0.15, clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: transparent,
                    border: Border.all(color: clr, width: 3)),
                child: Center(
                  child: CircleAvatar(
                    radius: w * 0.07,
                    backgroundImage: AssetImage(profile),
                  ),
                ),
              ),
            ],
          ),
        ));
  });
}
