import 'package:daamn/constant/exports.dart';

class ChatProvider extends ChangeNotifier {
  late Stream<QuerySnapshot> chatStream;
  late Stream<DocumentSnapshot> userStream;

  void initializeChatStream(String chatId) {
    chatStream = getChatStream(chatId);
    ChangeNotifier();
  }

  void initializeUserStream(String userId) {
    userStream = getUserStream(userId);
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
