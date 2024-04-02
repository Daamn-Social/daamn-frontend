import 'package:daamn/constant/exports.dart';
import 'package:daamn/providers/streams_provider.dart';

class BordingScreen02 extends StatefulWidget {
  final String videoURL;
  final String question;
  final List<dynamic> answers;
  final int len;
  final void Function()? onNext;
  const BordingScreen02(
      {required this.videoURL,
      required this.question,
      required this.answers,
      required this.len,
      required this.onNext,
      super.key});

  @override
  State<BordingScreen02> createState() => _BordingScreen02State();
}

class _BordingScreen02State extends State<BordingScreen02> {
  @override
  Widget build(BuildContext context) {
    final watchData = context.watch<DataStreamProvider>();

    return DoubleScafold(
      videoUrl: widget.videoURL,
      child: Column(
        //   mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpacer(space: 0.04),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleAvatar(
                backgroundColor: primaryColor,
                child: IconButton(
                    onPressed: widget.onNext,
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    )),
              )
            ],
          ),
          const Spacer(),
          appTextGiloryBlack(
              isCenter: false, textString: widget.question, fontSize: 22),
          verticalSpacer(space: 0.01),
          if (widget.len >= 30) ...{
            SizedBox(
              width: screenWidth,
              height: screenHieght * 0.25,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: (widget.answers.length),
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: screenWidth * 0.9,
                    child: chipContainer(
                      tittle: widget.answers[index],
                      isSelected:
                          watchData.selectedAnswer == index ? true : false,
                      ontap: () {
                        context
                            .read<DataStreamProvider>()
                            .updateSelectedAnswer(index);
                      },
                    ),
                  );
                },
              ),
            )
          } else ...{
            Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  for (int i = 0; i < widget.answers.length; i++)
                    chipContainer(
                      tittle: widget.answers[i],
                      isSelected: watchData.selectedAnswer == i ? true : false,
                      ontap: () {
                        context
                            .read<DataStreamProvider>()
                            .updateSelectedAnswer(i);
                      },
                    ),
                ],
              ),
            ),
          },
          verticalSpacer(space: 0.01),
        ],
      ),
    );
  }
}
