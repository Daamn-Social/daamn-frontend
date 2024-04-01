import 'package:daamn/constant/exports.dart';
import 'package:daamn/screens/bording_screens/bording_screen_08.dart';

class BordingScreen07 extends StatefulWidget {
  const BordingScreen07({super.key});

  @override
  State<BordingScreen07> createState() => _BordingScreen07State();
}

class _BordingScreen07State extends State<BordingScreen07> {
  int selectedItem = 1;
  updateSelected(int value) {
    setState(() {
      selectedItem = value;
    });
    AppNavigator.to(const BordingScreen08());
  }

  List<String> activities = [
    "Music Festivals & Concerts",
    "Hitting up parties and social events",
    "Side hustle or part-time gig",
    "Sleep. Catching up on much-needed rest.",
    "Exploring new places",
    "Trying out new restaurants or bars",
    "Study sessions that are actually fun"
  ];

  @override
  Widget build(BuildContext context) {
    return DoubleScafold(
      videoUrl:
          'https://firebasestorage.googleapis.com/v0/b/daamn-28e40.appspot.com/o/bording%2F7%20weekend.mp4?alt=media&token=1d22ef57-202a-4195-9a3d-2f20fde0bdb2',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appTextGiloryBlack(
              isCenter: false,
              textString: 'Level up your weekend! What gets you PUMPED?',
              fontSize: 22),
          verticalSpacer(space: 0.01),
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                for (int i = 0; i < activities.length; i++)
                  chipContainer(
                    tittle: activities[i],
                    isSelected: selectedItem == i ? true : false,
                    ontap: () {
                      updateSelected(i);
                    },
                  ),
              ],
            ),
          ),
          verticalSpacer(space: 0.01),
        ],
      ),
    );
  }
}
