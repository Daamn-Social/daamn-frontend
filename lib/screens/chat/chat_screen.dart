// ignore_for_file: library_private_types_in_public_api, prefer_interpolation_to_compose_strings

import 'dart:async';
import 'package:daamn/constant/exports.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final String userID;
  final String userName;
  final String userImage;
  const ChatScreen(
      {required this.userID,
      required this.userImage,
      required this.userName,
      super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    String chatId = FirebaseAuth.instance.currentUser!.uid + widget.userID;
    return SafeArea(
      child: Scaffold(
        backgroundColor: appBlackColor,
        body: Container(
          height: h,
          width: w,
          decoration: const BoxDecoration(
            image:
                DecorationImage(image: AssetImage(bgImage), fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              verticalSpacer(space: 0.01),
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.userID)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      child: Row(
                        children: [
                          horizontalSpacer(space: 0.02),
                          IconButton(
                              onPressed: () {
                                AppNavigator.off();
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: appWhiteColor,
                              )),
                          CircleAvatar(
                            backgroundImage: NetworkImage(widget.userImage != ''
                                ? widget.userImage
                                : 'https://via.placeholder.com/150'),
                          ),
                          horizontalSpacer(space: 0.02),
                          appTextGiloryBlack(
                              textString: widget.userName, isCenter: false),
                        ],
                      ),
                    );
                  }

                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return SizedBox(
                      child: Row(
                        children: [
                          horizontalSpacer(space: 0.02),
                          IconButton(
                              onPressed: () {
                                AppNavigator.off();
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: appWhiteColor,
                              )),
                          CircleAvatar(
                            backgroundImage: NetworkImage(widget.userImage != ''
                                ? widget.userImage
                                : 'https://via.placeholder.com/150'),
                          ),
                          horizontalSpacer(space: 0.02),
                          appTextGiloryBlack(
                              textString: widget.userName, isCenter: false),
                        ],
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  return SizedBox(
                    child: Row(
                      children: [
                        horizontalSpacer(space: 0.02),
                        IconButton(
                            onPressed: () {
                              AppNavigator.off();
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: appWhiteColor,
                            )),
                        CircleAvatar(
                          backgroundImage: NetworkImage(widget.userImage != ''
                              ? widget.userImage
                              : 'https://via.placeholder.com/150'),
                        ),
                        horizontalSpacer(space: 0.02),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            appTextGiloryBlack(
                                textString: snapshot.data!['name'],
                                isCenter: false),
                            snapshot.data!['online_Status'] == 'Offline'
                                ? appTextGiloryMedium(
                                    textString: "Seen " +
                                        getTimeDifferenceString(
                                            snapshot.data!['last_seen']),
                                    fontSize: 10)
                                : appTextGiloryMedium(
                                    textString: snapshot.data!['online_Status'],
                                    fontSize: 10)
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              Expanded(
                  child: SizedBox(
                width: w * 0.9,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("chat")
                      .doc(chatId)
                      .collection('oneToOne')
                      .orderBy('timestamp', descending: false)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                          child: Text(
                        'Send message',
                        style: TextStyle(color: appWhiteColor),
                      ));
                    }

                    return GroupedListView(
                      sort: true,
                      reverse: true,
                      order: GroupedListOrder.DESC,
                      floatingHeader: true,
                      useStickyGroupSeparators: true,
                      elements: snapshot.data!.docs,
                      groupBy: (element) => DateTime(
                        element['timestamp'].toDate().year,
                        element['timestamp'].toDate().month,
                        element['timestamp'].toDate().day,
                      ),
                      groupHeaderBuilder: (element) => SizedBox(
                        height: 40,
                        child: Center(
                            child: Card(
                          surfaceTintColor: primaryColor,
                          color: primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: appTextGiloryMedium(
                                textString: DateFormat.yMMMd()
                                    .format(element['timestamp'].toDate()),
                                color: Colors.white),
                          ),
                        )),
                      ),
                      itemBuilder: (context, element) => Align(
                        alignment: element['senderId'] ==
                                FirebaseAuth.instance.currentUser!.uid
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: SizedBox(
                          //width: w * 0.6,
                          child: Card(
                            color: element['senderId'] !=
                                    FirebaseAuth.instance.currentUser!.uid
                                ? Colors.white
                                : primaryColor,
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: appTextGiloryMedium(
                                  isCenter: false,
                                  textString: element['message'],
                                  color: element['senderId'] ==
                                          FirebaseAuth.instance.currentUser!.uid
                                      ? appWhiteColor
                                      : Colors.black),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )),
              _buildMessageInput(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: appTextField(
        controler: _textController,
        onchange: (value) {},
        hintText: "Your message..",
        keyBordType: TextInputType.text,
        maxLiness: 1,
        sufixWidgit: InkWell(
          onTap: () {
            sendMessage();
          },
          child: Container(
            margin: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: primaryColor,
            ),
            child: const Icon(
              Icons.send,
              color: appWhiteColor,
            ),
          ),
        ),
        fieldvalivator: (value) => null,
      ),
    );
  }

  Future<void> sendMessage() async {
    FocusScope.of(context).unfocus();
    String currentUserID = FirebaseAuth.instance.currentUser!.uid.toString();
    String chatId = FirebaseAuth.instance.currentUser!.uid + widget.userID;
    String chatIDForFriend = widget.userID + currentUserID;
    String messageLast = _textController.text;
    Map<String, dynamic> message = {
      'senderId': currentUserID,
      'receiverId': widget.userID,
      'message': _textController.text,
      'timestamp': DateTime.now(),
      'type': 'text', // Default value
      'image': ''
    };
    _textController.clear();
    UserModel? userdataSaved =
        await context.read<GoogleSignInProvider>().getUserData();
    //----------------- savefor me
    await FirebaseFirestore.instance
        .collection('chatList')
        .doc(currentUserID)
        .collection('chat')
        .doc(widget.userID)
        .set({
      'id': widget.userID,
      'name': widget.userName,
      'image': widget.userImage,
      'lastMes': messageLast,
      'unread_count': 0,
      'time': DateTime.now(),
    }).whenComplete(() => debugPrint(""));
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserID)
        .collection('chat')
        .doc(chatId)
        .collection('oneToOne')
        .add(message)
        .whenComplete(() => debugPrint(""));

    //----------------- savefor friend

    await FirebaseFirestore.instance
        .collection('chatList')
        .doc(widget.userID)
        .collection('chat')
        .doc(currentUserID)
        .set({
      'id': currentUserID,
      'name': userdataSaved!.name,
      'image': userdataSaved.image,
      'lastMes': messageLast,
      'unread_count': 0,
      'time': DateTime.now(),
    }).whenComplete(() => debugPrint(""));
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userID)
        .collection('chat')
        .doc(chatIDForFriend)
        .collection('oneToOne')
        .add(message)
        .whenComplete(() => debugPrint(""));
  }
}

class ChatMessage {
  final String text;
  final bool isMe;
  final DateTime date;
  final String imageUrl;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.imageUrl,
    required this.date,
  });
}
