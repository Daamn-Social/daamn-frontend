import 'package:daamn/constant/exports.dart';
import 'package:daamn/providers/streams_provider.dart';
import 'package:daamn/screens/bording_screens/bording_screen_01.dart';

class MainBordingScreen extends StatefulWidget {
  const MainBordingScreen({super.key});

  @override
  State<MainBordingScreen> createState() => _MainBordingScreenState();
}

class _MainBordingScreenState extends State<MainBordingScreen> {
  late PageController _pageController;
  int _currentPageIndex = 0;

  final TextEditingController textController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);
    getBordingData();
  }

  getBordingData() {
    Provider.of<DataStreamProvider>(context, listen: false).getBordingData();
  }

  void _turnPage(bool forward) {
    setState(() {
      _currentPageIndex =
          forward ? _currentPageIndex + 1 : _currentPageIndex - 1;
      _pageController.animateToPage(
        _currentPageIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final watchData = context.watch<DataStreamProvider>();
    return watchData.bordingDataScreen == null
        ? appLoadingContainer(height: screenHieght)
        : PageView.builder(
            controller: _pageController,
            itemCount: watchData.bordingDataScreen!.docs.length,
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex = index;
              });
              if (watchData.bordingDataScreen!.docs[index]['type'] ==
                  "input") {}
            },
            itemBuilder: (context, index) {
              final data = watchData.bordingDataScreen!.docs[index];

              if (data['type'] == "input") {
                return BordingScreen01(
                  myControler: textController,
                  question: data['question'],
                  videoURL: data['vid'],
                  hint: data['ans'].toString().contains('name')
                      ? watchData.currentUserData!['name'].toString()
                      : data['ans'],
                  onSubmit: () {
                    if (_currentPageIndex <
                        watchData.bordingDataScreen!.docs.length) {
                      _turnPage(true);
                    }
                    FocusScope.of(context).unfocus();
                    updateUserData(
                        data: {'${data['param']}': textController.text});
                  },
                );
              } else {
                return BordingScreen02(
                  question: data['question'],
                  videoURL: data['vid'],
                  answers: data['ans'],
                  len: data['lenght'],
                  onNext: () {
                    if (_currentPageIndex <
                        watchData.bordingDataScreen!.docs.length) {
                      _turnPage(true);
                    }
                    if (_currentPageIndex ==
                        watchData.bordingDataScreen!.docs.length) {
                      AppNavigator.toAndRemoveUntil(const BottomBArView());
                    }

                    context.read<DataStreamProvider>().addUserInterest(
                        interestTxt: data['ans'][watchData.selectedAnswer]);
                  },
                );
              }
            },
          );
  }
}
