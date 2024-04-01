import 'package:daamn/constant/exports.dart';

class BordingScreen02 extends StatefulWidget {
  const BordingScreen02({super.key});

  @override
  State<BordingScreen02> createState() => _BordingScreen02State();
}

class _BordingScreen02State extends State<BordingScreen02> {
  int selectedItem = 1;
  updateSelected(int value) {
    setState(() {
      selectedItem = value;
    });
    AppNavigator.to(const BordingScreen03());
  }

  @override
  Widget build(BuildContext context) {
    return DoubleScafold(
      videoUrl:
          'https://firebasestorage.googleapis.com/v0/b/daamn-28e40.appspot.com/o/bording%2F2%20identify.mp4?alt=media&token=c4636c59-96a6-4367-91bb-42101561e53e',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appTextGiloryBlack(
              isCenter: false, textString: 'How do you identify', fontSize: 22),
          verticalSpacer(space: 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              chipContainer(
                tittle: "Male",
                isSelected: selectedItem == 0 ? true : false,
                ontap: () {
                  updateSelected(0);
                },
              ),
              chipContainer(
                tittle: "Male",
                isSelected: selectedItem == 1 ? true : false,
                ontap: () {
                  updateSelected(1);
                },
              ),
              chipContainer(
                tittle: "Other",
                isSelected: selectedItem == 2 ? true : false,
                ontap: () {
                  updateSelected(2);
                },
              )
            ],
          ),
          verticalSpacer(space: 0.01),
        ],
      ),
    );
  }
}
