import '../../../constant/exports.dart';

class SocialMediaDialoge extends StatefulWidget {
  final Map<String, dynamic> socalMeia;
  const SocialMediaDialoge({
    required this.socalMeia,
    super.key,
  });

  @override
  State<SocialMediaDialoge> createState() => _SocialMediaDialogeState();
}

class _SocialMediaDialogeState extends State<SocialMediaDialoge> {
  TextEditingController instgramControler = TextEditingController();
  TextEditingController snapControler = TextEditingController();
  TextEditingController tictokControler = TextEditingController();
  TextEditingController youtubeControler = TextEditingController();

  @override
  void initState() {
    asignData();
    super.initState();
  }

  asignData() {
    instgramControler.text = widget.socalMeia['instagram'];
    youtubeControler.text = widget.socalMeia['youtube'];
    snapControler.text = widget.socalMeia['snapchat'];
    tictokControler.text = widget.socalMeia['tictok'];
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: primaryColor,
          gradient: primaryGradiant,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: appTextGiloryMedium(
                    textString: "Social media",
                    fontSize: 22,
                    fontweight: FontWeight.w600),
              ),
              appTextGiloryMedium(
                  textString: "Instagram",
                  fontSize: 16,
                  fontweight: FontWeight.w600),
              appTextField(
                controler: instgramControler,
                onchange: (value) {},
                removeBorder: true,
                hintText: "Add intsgram profile link",
                keyBordType: TextInputType.text,
                maxLiness: 1,
                fieldvalivator: (value) => null,
              ),
              verticalSpacer(space: 0.02),
              appTextGiloryMedium(
                  textString: "SnapChat",
                  fontSize: 16,
                  fontweight: FontWeight.w600),
              appTextField(
                controler: snapControler,
                onchange: (value) {},
                removeBorder: true,
                hintText: "Add Snapchat profile link",
                keyBordType: TextInputType.text,
                maxLiness: 1,
                fieldvalivator: (value) => null,
              ),
              verticalSpacer(space: 0.02),
              appTextGiloryMedium(
                  textString: "Youtube",
                  fontSize: 16,
                  fontweight: FontWeight.w600),
              appTextField(
                controler: youtubeControler,
                onchange: (value) {},
                removeBorder: true,
                hintText: "Add Youtube  link",
                keyBordType: TextInputType.text,
                maxLiness: 1,
                fieldvalivator: (value) => null,
              ),
              verticalSpacer(space: 0.02),
              appTextGiloryMedium(
                  textString: "TikTok",
                  fontSize: 16,
                  fontweight: FontWeight.w600),
              appTextField(
                controler: tictokControler,
                onchange: (value) {},
                removeBorder: true,
                hintText: "Add TikTok profile link",
                keyBordType: TextInputType.text,
                maxLiness: 1,
                fieldvalivator: (value) => null,
              ),
              verticalSpacer(space: 0.04),
              appButton(
                  buttonText: "Confirm",
                  ontapfunction: () async {
                    QuickAlert.show(
                        context: context,
                        type: QuickAlertType.loading,
                        backgroundColor: transparent,
                        headerBackgroundColor: transparent);
                    await FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .update({
                      'social_links': [
                        {
                          'youtube': youtubeControler.text,
                          'instagram': instgramControler.text,
                          'snapchat': snapControler.text,
                          'tictok': tictokControler.text,
                        }
                      ]
                    }).whenComplete(() {
                      AppNavigator.off();
                    }).onError((error, stackTrace) {
                      snaki(msg: "Some thing rong Try again later");
                    });
                    AppNavigator.off();
                  },
                  buttonColor: Colors.white,
                  textColor: appBlackColor)
            ],
          ),
        ),
      ),
    );
  }
}
