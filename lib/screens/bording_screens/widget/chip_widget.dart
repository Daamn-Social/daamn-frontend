import 'package:daamn/constant/exports.dart';

Widget chipContainer(
    {required String tittle,
    void Function()? ontap,
    required bool isSelected}) {
  return GestureDetector(
    onTap: ontap,
    child: isSelected
        ? Container(
            margin: const EdgeInsets.all(6),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
                gradient: primaryGradiant,
                borderRadius: BorderRadius.circular(25)),
            child: appTextGiloryMedium(
              textString: tittle,
              fontSize: 16,
            ),
          )
        : Container(
            margin: const EdgeInsets.all(6),
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                gradient: pinktoblack, borderRadius: BorderRadius.circular(25)),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              decoration: BoxDecoration(
                  color: appBlackColor,
                  borderRadius: BorderRadius.circular(25)),
              child: appTextGiloryMedium(
                textString: tittle,
                fontSize: 16,
              ),
            ),
          ),
  );
}
