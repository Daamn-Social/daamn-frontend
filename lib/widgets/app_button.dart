import 'package:daamn/constant/exports.dart';

Widget appButton(
    {required String buttonText,
    required void Function() ontapfunction,
    Color? textColor,
    Color? buttonColor,
    double? radius,
    double? fontSize}) {
  return Builder(builder: (context) {
    return GestureDetector(
      onTap: ontapfunction,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          gradient: blackandWhiteGradiant,
          boxShadow: customShadow,
          // color: primaryColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: primaryGradiant,
            borderRadius: BorderRadius.circular(25),
          ),
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: Center(
            child: Text(
              buttonText,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: textColor ?? appWhiteColor,
                  fontSize: fontSize ?? 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  });
}

Widget loaderappButton({
  Color? buttonColor,
}) {
  return Builder(builder: (context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        backgroundColor: buttonColor != null
            ? MaterialStateProperty.all(buttonColor)
            : MaterialStateProperty.all(
                Colors.black,
              ),
      ),
      onPressed: () {},
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: const Center(
          child: SpinKitThreeBounce(color: Colors.white, size: 20),
        ),
      ),
    );
  });
}

Widget appButtonwithIcon({
  required IconData iconString,
  required Color bg,
  required Color ic,
  required void Function() ontapfunction,
}) {
  return Builder(builder: (context) {
    return InkWell(
      onTap: ontapfunction,
      child: Container(
        decoration: BoxDecoration(
          color: bg,
          border: Border.all(
            width: 0.5,
            color: Colors.grey.shade300,
          ),
        ),
        height: 50,
        width: 50,
        child: Center(
          child: Icon(
            iconString,
            size: 35,
            color: ic,
          ),
        ),
      ),
    );
  });
}

Widget appButtonwithText({
  required String txt,
  required Color bg,
  required void Function() ontapfunction,
}) {
  return Builder(builder: (context) {
    return InkWell(
      onTap: ontapfunction,
      child: Container(
        decoration: BoxDecoration(
          color: bg,
          border: Border.all(
            width: 0.5,
            color: Colors.grey.shade300,
          ),
        ),
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Center(
            child: appTextGiloryBlack(
                color: bg == primaryColor ? Colors.white : Colors.black,
                textString: txt,
                fontSize: 16,
                fontweight: FontWeight.bold)),
      ),
    );
  });
}
