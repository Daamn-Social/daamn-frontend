import 'package:daamn/constant/exports.dart';

class DataStreamProvider extends ChangeNotifier {
  late Stream<QuerySnapshot> chatStream;
  late Stream<DocumentSnapshot> userStream;
  late Stream<DocumentSnapshot> currentUserStream;

  void initializeChatStream(String chatId) {
    chatStream = getChatStream(chatId);
    ChangeNotifier();
  }

  void initializeUserStream(String userId) {
    userStream = getUserStream(userId);
    ChangeNotifier();
  }

  void initializeCurrenTuserStream() {
    currentUserStream = getCurrentUserStream();
    ChangeNotifier();
  }
}

Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStream(String id) {
  Stream<DocumentSnapshot<Map<String, dynamic>>> userStream =
      FirebaseFirestore.instance.collection('users').doc(id).snapshots();
  return userStream;
}

Stream<QuerySnapshot<Map<String, dynamic>>> getChatStream(String id) {
  Stream<QuerySnapshot<Map<String, dynamic>>> userStream = FirebaseFirestore
      .instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("chat")
      .doc(id)
      .collection('oneToOne')
      .orderBy('timestamp', descending: false)
      .snapshots();
  return userStream;
}

Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentUserStream() {
  Stream<DocumentSnapshot<Map<String, dynamic>>> userStream = FirebaseFirestore
      .instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .snapshots();
  return userStream;
}
