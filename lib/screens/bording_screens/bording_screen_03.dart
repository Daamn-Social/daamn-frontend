import 'package:daamn/constant/exports.dart';
import 'package:daamn/screens/bording_screens/bording_screen_04.dart';

class BordingScreen03 extends StatefulWidget {
  const BordingScreen03({super.key});

  @override
  State<BordingScreen03> createState() => _BordingScreen01State();
}

class _BordingScreen01State extends State<BordingScreen03> {
  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DoubleScafold(
      videoUrl:
          'https://firebasestorage.googleapis.com/v0/b/daamn-28e40.appspot.com/o/bording%2F3%20birthday.mp4?alt=media&token=39be366e-b6ed-458e-bc8a-0749f875c7d9',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          appTextGiloryBlack(
              isCenter: false,
              textString: "When's your birthday? Let's celebrate!",
              fontSize: 22),
          verticalSpacer(space: 0.01),
          appTextField(
            controler: textController,
            removeBorder: true,
            onchange: (value) {},
            hintText: "dd/mm/yyy",
            keyBordType: TextInputType.number,
            maxLiness: 1,
            sufixWidgit: InkWell(
              onTap: () {
                AppNavigator.to(const BordingScreen04());
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
