import 'package:daamn/constant/exports.dart';
import 'package:daamn/screens/bording_screens/bording_screen_06.dart';

class BordingScreen04 extends StatefulWidget {
  const BordingScreen04({super.key});

  @override
  State<BordingScreen04> createState() => _BordingScreen01State();
}

class _BordingScreen01State extends State<BordingScreen04> {
  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DoubleScafold(
      videoUrl:
          'https://firebasestorage.googleapis.com/v0/b/daamn-28e40.appspot.com/o/bording%2F4%20university.mp4?alt=media&token=e53ba37e-4e56-45e8-ba9f-c5be88ed1fd3',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          appTextGiloryBlack(
              isCenter: false,
              textString:
                  "Let's connect you with your campus – what's your university?",
              fontSize: 22),
          verticalSpacer(space: 0.01),
          appTextField(
            controler: textController,
            removeBorder: true,
            onchange: (value) {},
            hintText: "University Name",
            keyBordType: TextInputType.text,
            maxLiness: 1,
            sufixWidgit: InkWell(
              onTap: () {
                AppNavigator.to(const BordingScreen06());
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
