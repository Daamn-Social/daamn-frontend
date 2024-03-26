import 'package:daamn/constant/exports.dart';

class GetUserDataProvider extends ChangeNotifier {
  DocumentSnapshot<Map<String, dynamic>>? userData;
  getUserdata() async {
    userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
  }
}
