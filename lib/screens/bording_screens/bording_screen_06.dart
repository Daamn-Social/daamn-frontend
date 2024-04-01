import 'package:daamn/constant/exports.dart';
import 'package:daamn/screens/bording_screens/bording_screen_07.dart';

class BordingScreen06 extends StatefulWidget {
  const BordingScreen06({super.key});

  @override
  State<BordingScreen06> createState() => _BordingScreen06State();
}

class _BordingScreen06State extends State<BordingScreen06> {
  int selectedItem = 1;
  updateSelected(int value) {
    setState(() {
      selectedItem = value;
    });
    AppNavigator.to(const BordingScreen07());
  }

  @override
  Widget build(BuildContext context) {
    return DoubleScafold(
      videoUrl:
          'https://firebasestorage.googleapis.com/v0/b/daamn-28e40.appspot.com/o/bording%2F6-social%20spectrum.mp4?alt=media&token=c792df50-607c-4608-9888-7d4db7cc6dd5',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appTextGiloryBlack(
              isCenter: false,
              textString: 'Where do you fall on the social spectrum?',
              fontSize: 22),
          verticalSpacer(space: 0.01),
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                chipContainer(
                  tittle: "Introvert ",
                  isSelected: selectedItem == 0 ? true : false,
                  ontap: () {
                    updateSelected(0);
                  },
                ),
                chipContainer(
                  tittle: "Extrovert ",
                  isSelected: selectedItem == 1 ? true : false,
                  ontap: () {
                    updateSelected(1);
                  },
                ),
                chipContainer(
                  tittle: "Ambivert",
                  isSelected: selectedItem == 2 ? true : false,
                  ontap: () {
                    updateSelected(2);
                  },
                )
              ],
            ),
          ),
          verticalSpacer(space: 0.01),
        ],
      ),
    );
  }
}
