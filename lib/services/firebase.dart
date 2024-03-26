import 'package:daamn/constant/exports.dart';

void clearOneToOneCollection(String userID) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    // print("User not logged in");
    return;
  }
  await FirebaseFirestore.instance
      .collection('chatList')
      .doc(user.uid)
      .collection('chat')
      .doc(userID)
      .update({
    'lastMes': '',
  }).whenComplete(() => debugPrint(""));
  final userDocRef =
      FirebaseFirestore.instance.collection("users").doc(user.uid);
  final chatDocRef = userDocRef.collection('chat').doc(user.uid + userID);
  final oneToOneCollectionRef = chatDocRef.collection('oneToOne');

  await _deleteCollection(oneToOneCollectionRef);
}

Future<void> _deleteCollection(CollectionReference collectionRef) async {
  const batchSize = 20;
  QuerySnapshot querySnapshot;

  do {
    querySnapshot = await collectionRef.limit(batchSize).get();
    for (DocumentSnapshot doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  } while (querySnapshot.size > 0);

  return;
}

void deleteChat(String userID) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    print("User not logged in");
    return;
  }

  final userDocRef =
      FirebaseFirestore.instance.collection("chatList").doc(user.uid);
  final chatDocRef = userDocRef.collection('chat').doc(userID);

  // Delete the "chat" collection for the specific user
  await chatDocRef.delete();
  clearOneToOneCollection(userID);
}
