import 'package:daamn/constant/exports.dart';

AppBar commonAppBar(
    {required String tittle, double? fontSize, List<Widget>? actionsWidgets}) {
  return AppBar(
    backgroundColor: primaryColor,
    leading: Builder(builder: (context) {
      return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios),
      );
    }),
    iconTheme: const IconThemeData(
      color: Colors.white, //change your color here
    ),
    title: Text(
      tittle,
      style: TextStyle(color: Colors.white, fontSize: fontSize ?? 16),
    ),
    actions: actionsWidgets ?? [],
  );
}
