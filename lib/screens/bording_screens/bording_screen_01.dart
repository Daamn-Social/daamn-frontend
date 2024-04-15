import 'package:daamn/constant/exports.dart';

class BordingScreen01 extends StatefulWidget {
  final String videoURL;
  final String question;
  final String hint;
  final TextEditingController myControler;
  final void Function()? onSubmit;
  const BordingScreen01(
      {required this.videoURL,
      required this.question,
      required this.hint,
      required this.onSubmit,
      required this.myControler,
      super.key});

  @override
  State<BordingScreen01> createState() => _BordingScreen01State();
}

class _BordingScreen01State extends State<BordingScreen01> {
  @override
  void initState() {
    super.initState();

    widget.myControler.text = widget.hint;
  }

  @override
  Widget build(BuildContext context) {
    return DoubleScafold(
      videoUrl: widget.videoURL,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          appTextGiloryBlack(
              isCenter: false, textString: widget.question, fontSize: 22),
          verticalSpacer(space: 0.01),
          appTextField(
            controler: widget.myControler,
            removeBorder: true,
            onchange: (value) {},
            hintText: widget.hint,
            keyBordType: TextInputType.text,
            maxLiness: 1,
            sufixWidgit: InkWell(
              onTap: widget.onSubmit,
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
