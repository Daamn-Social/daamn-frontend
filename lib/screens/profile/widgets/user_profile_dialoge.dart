import 'dart:io';
import 'dart:ui';

import 'package:daamn/providers/shared/image_picker_provider.dart';
import 'package:daamn/services/firebase.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/exports.dart';

class UserprofileDialoge extends StatefulWidget {
  final String name;
  final String? bio;
  final String? img;
  const UserprofileDialoge({
    required this.name,
    this.bio,
    this.img,
    super.key,
  });

  @override
  State<UserprofileDialoge> createState() => _UserprofileDialogeState();
}

class _UserprofileDialogeState extends State<UserprofileDialoge> {
  TextEditingController nameControler = TextEditingController();
  TextEditingController bioControler = TextEditingController();

  @override
  void initState() {
    asignData();
    super.initState();
  }

  asignData() {
    nameControler.text = widget.name;
    bioControler.text = widget.bio!;
  }

  @override
  Widget build(BuildContext context) {
    final watchmage = context.watch<ImagePickerProvider>();
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
            border: const GradientBoxBorder(
              gradient: LinearGradient(
                  colors: [primaryColor, Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  width: screenWidth,
                  decoration: BoxDecoration(gradient: primaryGradiant),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      appTextGiloryBlack(
                          textString: 'Edit Profile', fontSize: 24),
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
                watchmage.postimage != null
                    ? GestureDetector(
                        onTap: () {
                          context.read<ImagePickerProvider>().custonImagePIcker(
                              sourceimage: ImageSource.gallery);
                        },
                        child: Center(
                          child: Container(
                            width: screenWidth * 0.28,
                            height: screenHieght * 0.15,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              gradient: primaryGradiant,
                              boxShadow: customShadow,
                              color: primaryColor.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: primaryColor),
                              image: DecorationImage(
                                  image: FileImage(watchmage.postimage!),
                                  fit: BoxFit.cover),

                              // shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          context.read<ImagePickerProvider>().custonImagePIcker(
                              sourceimage: ImageSource.gallery);
                        },
                        child: Center(
                          child: Container(
                            width: screenWidth * 0.28,
                            height: screenHieght * 0.15,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                gradient: primaryGradiant,
                                boxShadow: customShadow,
                                color: primaryColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: primaryColor)

                                ///shape: BoxShape.circle,
                                ),
                            child:
                                appCacheNetworkImageWidget(imgIRL: widget.img!),
                          ),
                        ),
                      ),
                Container(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      appTextGiloryMedium(
                          textString: "Name",
                          fontSize: 16,
                          fontweight: FontWeight.w600),
                      appTextField(
                        controler: nameControler,
                        onchange: (value) {},
                        removeBorder: true,
                        hintText: "Add Name",
                        keyBordType: TextInputType.text,
                        maxLiness: 1,
                        fieldvalivator: (value) => null,
                      ),
                      verticalSpacer(space: 0.02),
                      appTextGiloryMedium(
                          textString: "Bio",
                          fontSize: 16,
                          fontweight: FontWeight.w600),
                      appTextField(
                        controler: bioControler,
                        onchange: (value) {},
                        removeBorder: true,
                        hintText: "Add Bio",
                        keyBordType: TextInputType.text,
                        maxLiness: 5,
                        fieldvalivator: (value) => null,
                      ),
                      verticalSpacer(space: 0.04),
                      appButton(
                        buttonText: "Save",
                        fontSize: 22,
                        ontapfunction: () async {
                          final readmage = context.read<ImagePickerProvider>();
                          String useriD =
                              FirebaseAuth.instance.currentUser!.uid;
                          QuickAlert.show(
                              context: context,
                              type: QuickAlertType.loading,
                              backgroundColor: transparent,
                              headerBackgroundColor: transparent);
                          final prefs = await SharedPreferences.getInstance();
                          File? selectedImage = readmage.postimage;
                          String? imageUrl;
                          if (selectedImage != null) {
                            File imageFile = File(selectedImage.path);
                            imageUrl = await uploadImage(imageFile, useriD);
                          }
                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(useriD)
                              .update({
                            'image': imageUrl ?? widget.img,
                            'userBio': bioControler.text,
                            'name': nameControler.text,
                          }).whenComplete(() async {
                            await prefs.setString('name', nameControler.text);
                            await prefs.setString(
                                'image', imageUrl ?? widget.img!);
                            AppNavigator.off();
                            readmage.clean();
                          }).onError((error, stackTrace) {
                            snaki(msg: "Some thing rong Try again later");
                          });
                          AppNavigator.off();
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
