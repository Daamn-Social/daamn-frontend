import 'dart:ui';

import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import '../../../constant/exports.dart';

class UserInterestDialoge extends StatefulWidget {
  final List<dynamic> interest;
  const UserInterestDialoge({
    required this.interest,
    super.key,
  });

  @override
  State<UserInterestDialoge> createState() => _UserInterestDialogeState();
}

class _UserInterestDialogeState extends State<UserInterestDialoge> {
  TextEditingController intrestControler = TextEditingController();

  @override
  void initState() {
    asignData();
    super.initState();
  }

  asignData() {
    final readData = context.read<BottomNavBarProvider>();
    readData.assignInterest(listInteresr: widget.interest);
  }

  @override
  Widget build(BuildContext context) {
    final watchData = context.watch<BottomNavBarProvider>();
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: appBlackColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(16.0),
            border: const GradientBoxBorder(
              gradient: LinearGradient(
                  colors: [primaryColor, Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                // height: 30,
                width: screenWidth,
                decoration: BoxDecoration(gradient: primaryGradiant),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    appTextGiloryBlack(textString: 'Interests', fontSize: 24),
                    CircleAvatar(
                      child: IconButton(
                          onPressed: () {
                            AppNavigator.off();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: primaryColor,
                          )),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    height: screenHieght * 0.7,
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          verticalSpacer(space: 0.02),
                          Wrap(
                            spacing: 8.0, // spacing between each interest
                            runSpacing:
                                8.0, // spacing between rows of interests
                            children: List.generate(
                              watchData.userInterest.length,
                              (index) => Chip(
                                deleteIcon: const Icon(Icons.close),
                                onDeleted: () {
                                  watchData.deleteinterest(index: index);
                                },
                                label: appTextGiloryBlack(
                                    textString: watchData.userInterest[index],
                                    color: primaryColor),
                              ),
                            ),
                          ),
                          verticalSpacer(space: 0.02),
                          appTextField(
                            controler: intrestControler,
                            onchange: (value) {},
                            removeBorder: true,
                            hintText: "Interest",
                            keyBordType: TextInputType.text,
                            maxLiness: 1,
                            sufixWidgit: Container(
                              padding: const EdgeInsets.all(4),
                              child: InkWell(
                                onTap: () {
                                  if (intrestControler.text == "") {
                                    snaki(msg: "Add Interest");
                                  } else {
                                    watchData.addinterest(
                                        txt: intrestControler.text);
                                    intrestControler.clear();
                                  }
                                },
                                child: const CircleAvatar(
                                  backgroundColor: primaryColor,
                                  child: Icon(
                                    Icons.add,
                                    color: appWhiteColor,
                                  ),
                                ),
                              ),
                            ),
                            fieldvalivator: (value) => null,
                          ),
                          verticalSpacer(space: 0.02),
                          verticalSpacer(space: 0.04),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.7,
                    child: appButton(
                      buttonText: "Save",
                      fontSize: 22,
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
                          'interests': watchData.userInterest
                        }).whenComplete(() {
                          AppNavigator.off();
                        }).onError((error, stackTrace) {
                          snaki(msg: "Some thing rong Try again later");
                        });
                        AppNavigator.off();
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
