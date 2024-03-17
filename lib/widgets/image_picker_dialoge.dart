import 'package:daamn/constant/exports.dart';

class ImageSelectionDialog extends StatelessWidget {
  const ImageSelectionDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final myread = context.read<ImagePickerProvider>();
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      title: appText(
          textString: 'Select Image',
          fontweight: FontWeight.bold,
          color: primaryColor,
          fontSize: 20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text('Gallery'),
            onTap: () {
              //   myread.custonImagePIcker(sourceimage: ImageSource.gallery);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () {
              // myread.custonImagePIcker(sourceimage: ImageSource.camera);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
