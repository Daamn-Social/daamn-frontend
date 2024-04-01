import 'package:daamn/constant/exports.dart';

class BordingScreen10 extends StatefulWidget {
  const BordingScreen10({super.key});

  @override
  State<BordingScreen10> createState() => _BordingScreen07State();
}

class _BordingScreen07State extends State<BordingScreen10> {
  int selectedItem = 1;
  updateSelected(int value) {
    setState(() {
      selectedItem = value;
    });
    AppNavigator.toReplacement(const BottomBArView());
  }

  List<String> activities = [
    "Hiking & Trailblazing",
    "Camping & Outdoor Adventures",
    "Skiing & Snowboarding",
    "Watersports (Kayaking, Surfing, Paddleboarding)",
    "Rock Climbing & Bouldering",
    "Theme Parks & Roller Coasters",
    "Travel & Exploration"
  ];

  @override
  Widget build(BuildContext context) {
    return DoubleScafold(
      videoUrl:
          'https://firebasestorage.googleapis.com/v0/b/daamn-28e40.appspot.com/o/bording%2F10%20adventure.mp4?alt=media&token=55aa62fa-fd6c-4d11-a197-fa0a4de35b53',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appTextGiloryBlack(
              isCenter: false,
              textString: "adventure time! What's your thrill",
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
