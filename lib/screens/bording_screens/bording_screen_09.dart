import 'package:daamn/constant/exports.dart';
import 'package:daamn/screens/bording_screens/bording_screen_10.dart';

class BordingScreen09 extends StatefulWidget {
  const BordingScreen09({super.key});

  @override
  State<BordingScreen09> createState() => _BordingScreen07State();
}

class _BordingScreen07State extends State<BordingScreen09> {
  int selectedItem = 1;
  updateSelected(int value) {
    setState(() {
      selectedItem = value;
    });
    AppNavigator.to(const BordingScreen10());
  }

  List<String> activities = [
    "Running & Trail Exploring",
    "Gym Enthusiast",
    "Yoga & Flexibility Fanatic",
    "Sports",
    "Swimming & Water Sports",
    "Cycling & Biking",
    "Dance & Fitness Classes",
  ];

  @override
  Widget build(BuildContext context) {
    return DoubleScafold(
      videoUrl:
          'https://firebasestorage.googleapis.com/v0/b/daamn-28e40.appspot.com/o/bording%2F9%20stay_active.mp4?alt=media&token=6947c526-f14b-477d-ac78-2f2599961138',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appTextGiloryBlack(
              isCenter: false,
              textString: 'How do you like to stay active?',
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
