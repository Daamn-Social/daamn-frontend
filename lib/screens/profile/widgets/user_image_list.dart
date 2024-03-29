import 'dart:io';

import 'package:daamn/providers/shared/image_picker_provider.dart';
import 'package:daamn/services/firebase.dart';
import 'package:image_picker/image_picker.dart';
import 'package:badges/badges.dart' as badges;
import '../../../constant/exports.dart';

class UserImageList extends StatefulWidget {
  final List<dynamic> images;
  const UserImageList({
    required this.images,
    super.key,
  });

  @override
  State<UserImageList> createState() => _UserImageListState();
}

class _UserImageListState extends State<UserImageList> {
  TextEditingController intrestControler = TextEditingController();

  @override
  void initState() {
    asignData();
    super.initState();
  }

  asignData() {
    final readData = context.read<BottomNavBarProvider>();
    readData.assignimages(listInteresr: widget.images);
  }

  @override
  Widget build(BuildContext context) {
    final watchData = context.watch<BottomNavBarProvider>();
    final imageWacher = context.watch<ImagePickerProvider>();
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
              verticalSpacer(space: 0.02),
              Wrap(
                spacing: 12.0, // spacing between each images
                runSpacing: 8.0, // spacing between rows of images
                children: List.generate(
                  imageWacher.postimage != null
                      ? watchData.userimages.length + 2
                      : watchData.userimages.length + 1,
                  (index) {
                    if (index >= watchData.userimages.length) {
                      if (index == watchData.userimages.length &&
                          imageWacher.postimage != null) {
                        return Container(
                          height: 90,
                          width: 70,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: FileImage(imageWacher.postimage!),
                                  fit: BoxFit.cover),
                              color: appWhiteColor,
                              borderRadius: BorderRadius.circular(12)),
                        );
                      }
                      return InkWell(
                        onTap: () async {
                          if (watchData.userimages.length >= 5) {
                            snaki(msg: "You can add only five image");
                          } else {
                            await context
                                .read<ImagePickerProvider>()
                                .custonImagePIcker(
                                    sourceimage: ImageSource.gallery);
                          }

                          //  setState(() {});
                        },
                        child: Container(
                          height: 90,
                          width: 70,
                          decoration: BoxDecoration(
                              color: appWhiteColor,
                              borderRadius: BorderRadius.circular(12)),
                          child: const Center(
                            child: CircleAvatar(
                              backgroundColor: primaryColor,
                              child: Icon(
                                Icons.add,
                                color: appWhiteColor,
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return UserBadge(
                        imageUrl: watchData.userimages[index],
                        onClosePressed: () {
                          watchData.deleteimages(index: index);
                        },
                      );
                    }
                  },
                ),
              ),
              verticalSpacer(space: 0.04),
              appButton(
                  buttonText: "Save",
                  ontapfunction: () async {
                    if (widget.images.length > 5) {
                      snaki(msg: "You can add only five image");
                    } else {
                      final readmage = context.read<ImagePickerProvider>();
                      String useriD = FirebaseAuth.instance.currentUser!.uid;
                      QuickAlert.show(
                          context: context,
                          type: QuickAlertType.loading,
                          backgroundColor: transparent,
                          headerBackgroundColor: transparent);

                      File? selectedImage = readmage.postimage;
                      // print("picked image" + selectedImage.toString());

                      String? imageUrl;
                      if (selectedImage != null) {
                        File imageFile = File(selectedImage.path);
                        imageUrl = await uploadImage(imageFile, useriD);
                        watchData.addimages(txt: imageUrl);
                      }

                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(useriD)
                          .update({
                        'imagesList': watchData.userimages
                      }).whenComplete(() {
                        AppNavigator.off();
                      }).onError((error, stackTrace) {
                        snaki(msg: "Some thing rong Try again later");
                      });
                      readmage.clean();
                      AppNavigator.off();
                    }
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

class UserBadge extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onClosePressed;

  const UserBadge({
    super.key,
    required this.imageUrl,
    required this.onClosePressed,
  });

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
        badgeStyle: const badges.BadgeStyle(badgeColor: appWhiteColor),
        badgeContent: InkWell(
          onTap: onClosePressed,
          child: const Icon(
            Icons.close,
            size: 12,
          ),
        ),
        child: Container(
          height: 90,
          width: 70,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(imageUrl), fit: BoxFit.cover),
              color: appWhiteColor,
              borderRadius: BorderRadius.circular(12)),
        ));
  }
}
