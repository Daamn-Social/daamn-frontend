import 'package:daamn/providers/streams_provider.dart';

import '../../../constant/exports.dart';
import 'dart:ui';

class SocialMediaDialoge extends StatefulWidget {
  final List<dynamic> selected;
  const SocialMediaDialoge({
    required this.selected,
    super.key,
  });

  @override
  State<SocialMediaDialoge> createState() => _UserprofileDialogeState();
}

class _UserprofileDialogeState extends State<SocialMediaDialoge> {
  TextEditingController nameControler = TextEditingController();
  TextEditingController bioControler = TextEditingController();

  @override
  void initState() {
    asignData();
    super.initState();
  }

  List<dynamic> selectedIcons = [];

  asignData() {
    selectedIcons = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    //  final watchmage = context.watch<ImagePickerProvider>();
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
            //gradient: primaryGradiant,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                // height: 30,
                width: screenWidth,
                color: primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    appTextGiloryBlack(
                        textString: 'Social Profile', fontSize: 24),
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
              verticalSpacer(space: 0.02),
              Container(
                height: screenHieght * 0.75,
                padding: const EdgeInsets.all(2),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      appTextGiloryMedium(
                          textString: 'Social Media', fontSize: 18),
                      Wrap(
                        children: [
                          for (int i = 0; i < 8; i++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (selectedIcons.contains(i)) {
                                    selectedIcons.remove(i);
                                  } else {
                                    selectedIcons.add(i);
                                  }
                                });
                              },
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                color: selectedIcons.contains(i)
                                    ? primaryColor
                                    : Colors.white,
                                child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Center(
                                        child: SizedBox(
                                            width: 28,
                                            child: Image.asset(
                                                socialIcons[i].imagePath)))),
                              ),
                            )
                        ],
                      ),
                      verticalSpacer(space: 0.02),
                      appTextGiloryMedium(
                          textString: 'Messaging and Communication',
                          fontSize: 18),
                      Wrap(
                        children: [
                          for (int i = 8; i < 12; i++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (selectedIcons.contains(i)) {
                                    selectedIcons.remove(i);
                                  } else {
                                    selectedIcons.add(i);
                                  }
                                });
                              },
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                color: selectedIcons.contains(i)
                                    ? primaryColor
                                    : Colors.white,
                                child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Center(
                                        child: SizedBox(
                                            width: 28,
                                            child: Image.asset(
                                                socialIcons[i].imagePath)))),
                              ),
                            )
                        ],
                      ),
                      verticalSpacer(space: 0.02),
                      appTextGiloryMedium(
                          textString: 'Professional Networking', fontSize: 18),
                      Wrap(
                        children: [
                          for (int i = 12; i < 14; i++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (selectedIcons.contains(i)) {
                                    selectedIcons.remove(i);
                                  } else {
                                    selectedIcons.add(i);
                                  }
                                });
                              },
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                color: selectedIcons.contains(i)
                                    ? primaryColor
                                    : Colors.white,
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
                        ],
                      ),
                      verticalSpacer(space: 0.02),
                      appTextGiloryMedium(
                          textString: 'Video Sharing / Streaming',
                          fontSize: 18),
                      Wrap(
                        children: [
                          for (int i = 14; i < 17; i++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (selectedIcons.contains(i)) {
                                    selectedIcons.remove(i);
                                  } else {
                                    selectedIcons.add(i);
                                  }
                                });
                              },
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                color: selectedIcons.contains(i)
                                    ? primaryColor
                                    : Colors.white,
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
                        ],
                      ),
                      verticalSpacer(space: 0.02),
                      appTextGiloryMedium(
                          textString: 'Music Streaming', fontSize: 18),
                      Wrap(
                        children: [
                          for (int i = 17; i < 21; i++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (selectedIcons.contains(i)) {
                                    selectedIcons.remove(i);
                                  } else {
                                    selectedIcons.add(i);
                                  }
                                });
                              },
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                color: selectedIcons.contains(i)
                                    ? primaryColor
                                    : Colors.white,
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
                        ],
                      ),
                      verticalSpacer(space: 0.02),
                      appTextGiloryMedium(
                          textString: 'Gaming Platforms', fontSize: 18),
                      Wrap(
                        children: [
                          for (int i = 21; i < 25; i++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (selectedIcons.contains(i)) {
                                    selectedIcons.remove(i);
                                  } else {
                                    selectedIcons.add(i);
                                  }
                                });
                              },
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                color: selectedIcons.contains(i)
                                    ? primaryColor
                                    : Colors.white,
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
                        ],
                      ),
                      verticalSpacer(space: 0.02),
                      appTextGiloryMedium(
                          textString: 'Creative and Art Platforms',
                          fontSize: 18),
                      Wrap(
                        children: [
                          for (int i = 25; i < 30; i++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (selectedIcons.contains(i)) {
                                    selectedIcons.remove(i);
                                  } else {
                                    selectedIcons.add(i);
                                  }
                                });
                              },
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                color: selectedIcons.contains(i)
                                    ? primaryColor
                                    : Colors.white,
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
                        ],
                      ),
                      verticalSpacer(space: 0.02),
                      appTextGiloryMedium(
                          textString: 'Coding and Development', fontSize: 18),
                      Wrap(
                        children: [
                          for (int i = 30; i < 37; i++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (selectedIcons.contains(i)) {
                                    selectedIcons.remove(i);
                                  } else {
                                    selectedIcons.add(i);
                                  }
                                });
                              },
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                color: selectedIcons.contains(i)
                                    ? primaryColor
                                    : Colors.white,
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
                        ],
                      ),
                      verticalSpacer(space: 0.02),
                      appTextGiloryMedium(
                          textString: 'Health and Fitness', fontSize: 18),
                      Wrap(
                        children: [
                          for (int i = 37; i < 40; i++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (selectedIcons.contains(i)) {
                                    selectedIcons.remove(i);
                                  } else {
                                    selectedIcons.add(i);
                                  }
                                });
                              },
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                color: selectedIcons.contains(i)
                                    ? primaryColor
                                    : Colors.white,
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
                        ],
                      ),
                      verticalSpacer(space: 0.02),
                      appTextGiloryMedium(
                          textString: 'Travel and Experiences', fontSize: 18),
                      Wrap(
                        children: [
                          for (int i = 40; i < 43; i++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (selectedIcons.contains(i)) {
                                    selectedIcons.remove(i);
                                  } else {
                                    selectedIcons.add(i);
                                  }
                                });
                              },
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                color: selectedIcons.contains(i)
                                    ? primaryColor
                                    : Colors.white,
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
                        ],
                      ),
                      verticalSpacer(space: 0.02),
                      appTextGiloryMedium(
                          textString: 'Finance and Investment', fontSize: 18),
                      Wrap(
                        children: [
                          for (int i = 43; i < 46; i++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (selectedIcons.contains(i)) {
                                    selectedIcons.remove(i);
                                  } else {
                                    selectedIcons.add(i);
                                  }
                                });
                              },
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                color: selectedIcons.contains(i)
                                    ? primaryColor
                                    : Colors.white,
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
                        ],
                      ),
                      //=============================
                      verticalSpacer(space: 0.04),
                      appButton(
                        buttonText: "Save",
                        fontSize: 22,
                        ontapfunction: () async {
                          updateUserData(data: {'social_links': selectedIcons});
                          AppNavigator.off();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
