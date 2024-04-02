import 'dart:io';

import 'package:daamn/constant/exports.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
    return;
  }

  final userDocRef =
      FirebaseFirestore.instance.collection("chatList").doc(user.uid);
  final chatDocRef = userDocRef.collection('chat').doc(userID);

  // Delete the "chat" collection for the specific user
  await chatDocRef.delete();
  clearOneToOneCollection(userID);
}

Future<String> uploadImage(File imageFile, String userId) async {
  String fileExtension = imageFile.path.split('.').last;
  Reference ref = FirebaseStorage.instance
      .ref()
      .child('chat_images')
      .child('$userId${DateTime.now().millisecondsSinceEpoch}.$fileExtension');
  UploadTask uploadTask = ref.putFile(imageFile);
  TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
  return await taskSnapshot.ref.getDownloadURL();
}
