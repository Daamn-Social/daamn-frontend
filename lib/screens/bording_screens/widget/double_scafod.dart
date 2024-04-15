import 'package:daamn/constant/exports.dart';
import 'package:daamn/screens/bording_screens/videos/videoplayer2.dart';

class DoubleScafold extends StatelessWidget {
  final String videoUrl;
  final Widget child;
  const DoubleScafold({required this.videoUrl, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBlackColor,
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: screenWidth,
        height: screenHieght,
        child: Stack(
          children: [
            VieoPlayerWidget(
              url: videoUrl,
            ),
            Scaffold(
              backgroundColor: transparent,
              body: Container(
                  width: screenWidth,
                  height: screenHieght,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        transparent,
                        transparent,
                        transparent,
                        Colors.black
                      ])),
                  child: child),
            )
          ],
        ),
      ),
    );
  }
}
