import 'package:daamn/constant/exports.dart';

class DataStreamProvider extends ChangeNotifier {
  int selectedAnswer = 0;

  updateSelectedAnswer(int val) {
    selectedAnswer = val;
    notifyListeners();
  }

  late Stream<QuerySnapshot> chatStream;
  late Stream<DocumentSnapshot> userStream;
  late Stream<DocumentSnapshot> currentUserStream;
  DocumentSnapshot<Map<String, dynamic>>? currentUserData;
  QuerySnapshot? bordingDataScreen;
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

  getBordingData() async {
    getSurrentUserdata();
    bordingDataScreen = await FirebaseFirestore.instance
        .collection('bording')
        .orderBy('id', descending: false)
        .get();

    notifyListeners();
  }

  getSurrentUserdata() async {
    currentUserData = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    notifyListeners();
  }

  addUserInterest({required String interstTxt}) async {
    List<dynamic> userIntrestsss = currentUserData!['interests'];
    userIntrestsss.add(interstTxt);
    updateUserData(data: {'interests': userIntrestsss});
    getSurrentUserdata();
    notifyListeners();
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

updateUserData({required Map<Object, Object?> data}) {
  FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .update(data);
}
