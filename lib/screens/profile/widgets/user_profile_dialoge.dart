import 'dart:io';

import 'package:daamn/providers/shared/image_picker_provider.dart';
import 'package:daamn/services/firebase.dart';
import 'package:image_picker/image_picker.dart';

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
              watchmage.postimage != null
                  ? GestureDetector(
                      onTap: () {
                        context.read<ImagePickerProvider>().custonImagePIcker(
                            sourceimage: ImageSource.gallery);
                      },
                      child: Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(watchmage.postimage!),
                                fit: BoxFit.cover),
                            color: Colors.white,
                            shape: BoxShape.circle,
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
                          width: 100,
                          height: 100,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child:
                              appCacheNetworkImageWidget(imgIRL: widget.img!),
                        ),
                      ),
                    ),
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
                  textString: "Bio", fontSize: 16, fontweight: FontWeight.w600),
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
                  buttonText: "Update",
                  ontapfunction: () async {
                    final readmage = context.read<ImagePickerProvider>();
                    String useriD = FirebaseAuth.instance.currentUser!.uid;
                    QuickAlert.show(
                        context: context,
                        type: QuickAlertType.loading,
                        backgroundColor: transparent,
                        headerBackgroundColor: transparent);
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
                    }).whenComplete(() {
                      AppNavigator.off();
                      readmage.clean();
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
