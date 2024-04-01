import 'package:daamn/constant/exports.dart';
import 'package:daamn/screens/bording_screens/bording_screen_02.dart';
import 'package:daamn/screens/bording_screens/widget/double_scafod.dart';

class BordingScreen01 extends StatefulWidget {
  const BordingScreen01({super.key});

  @override
  State<BordingScreen01> createState() => _BordingScreen01State();
}

class _BordingScreen01State extends State<BordingScreen01> {
  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DoubleScafold(
      videoUrl:
          'https://firebasestorage.googleapis.com/v0/b/daamn-28e40.appspot.com/o/bording%2F1%20name.mp4?alt=media&token=2bdaf952-f7f9-45a9-ab9f-158fc7b63442',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          appTextGiloryBlack(
              isCenter: false,
              textString:
                  'Let’s start with something simple, what’s your name?',
              fontSize: 22),
          verticalSpacer(space: 0.01),
          appTextField(
            controler: textController,
            removeBorder: true,
            onchange: (value) {},
            hintText: "Your message..",
            keyBordType: TextInputType.text,
            maxLiness: 1,
            sufixWidgit: InkWell(
              onTap: () {
                AppNavigator.to(const BordingScreen02());
              },
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor,
                    gradient: primaryGradiant),
                child: const Icon(
                  Icons.send,
                  color: appWhiteColor,
                ),
              ),
            ),
            fieldvalivator: (value) => null,
          ),
        ],
      ),
    );
  }
}
