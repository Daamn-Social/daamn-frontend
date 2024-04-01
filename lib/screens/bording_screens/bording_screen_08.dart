import 'package:daamn/constant/exports.dart';
import 'package:daamn/screens/bording_screens/bording_screen_09.dart';

class BordingScreen08 extends StatefulWidget {
  const BordingScreen08({super.key});

  @override
  State<BordingScreen08> createState() => _BordingScreen07State();
}

class _BordingScreen07State extends State<BordingScreen08> {
  int selectedItem = 1;
  updateSelected(int value) {
    setState(() {
      selectedItem = value;
    });
    AppNavigator.to(const BordingScreen09());
  }

  List<String> sports = [
    'Football',
    'Soccer',
    'Baseball',
    'Ice hockey',
    'UFC',
    'Cricket',
    'Volleyball',
    'Badminton',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return DoubleScafold(
      videoUrl:
          'https://firebasestorage.googleapis.com/v0/b/daamn-28e40.appspot.com/o/bording%2F8%20sport.mp4?alt=media&token=39ed85e2-f8c2-475e-ab52-29afb9f71852',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appTextGiloryBlack(
              isCenter: false,
              textString: 'Which sport interests you?',
              fontSize: 22),
          verticalSpacer(space: 0.01),
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                for (int i = 0; i < sports.length; i++)
                  chipContainer(
                    tittle: sports[i],
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
