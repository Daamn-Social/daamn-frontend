// ignore_for_file: library_private_types_in_public_api, prefer_interpolation_to_compose_strings

import 'dart:async';
import 'package:daamn/constant/exports.dart';
import 'package:daamn/providers/shared/image_picker_provider.dart';
import 'package:daamn/providers/streams_provider.dart';
import 'package:daamn/screens/chat/widget/chat_header.dart';
import 'package:daamn/screens/chat/widget/hero_animation.dart';
import 'package:daamn/services/firebase.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:swipe_to/swipe_to.dart';
import 'package:badges/badges.dart' as badges;

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
  bool ischatReply = false;

  @override
  void initState() {
    super.initState();
    initalizeChat();
  }

  initalizeChat() {
    String chatId = FirebaseAuth.instance.currentUser!.uid + widget.userID;
    Provider.of<DataStreamProvider>(context, listen: false)
        .initializeChatStream(chatId);
    Provider.of<DataStreamProvider>(context, listen: false)
        .initializeUserStream(widget.userID);
  }

  Map replyMessage = {};

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: appBlackColor,
      body: Container(
        height: h,
        width: w,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ellipseSetting), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            verticalSpacer(space: 0.01),
            ChatMainHeader(
              userID: widget.userID,
              userName: widget.userName,
              userImage: widget.userImage,
            ),
            Consumer<DataStreamProvider>(
              builder: (context, DataStreamProvider, _) {
                return Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: DataStreamProvider.chatStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text(
                              'Send message',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }
                        String myID = FirebaseAuth.instance.currentUser!.uid;
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
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: primaryGradiant,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    DateFormat.yMMMd()
                                        .format(element['timestamp'].toDate()),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          itemBuilder: (context, element) => SwipeTo(
                            swipeSensitivity: 6,
                            onRightSwipe: (details) {
                              replyMessage = {
                                'name': element['senderId'] == myID
                                    ? 'You'
                                    : widget.userName,
                                'message': element['image'] == ''
                                    ? element['message']
                                    : 'image'
                              };
                              setState(() {
                                ischatReply = true;
                              });
                            },
                            child: Align(
                              alignment: element['senderId'] == myID
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: SizedBox(
                                //width: w * 0.6,
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  child: Column(
                                    crossAxisAlignment:
                                        element['senderId'] == myID
                                            ? CrossAxisAlignment.end
                                            : CrossAxisAlignment.start,
                                    children: [
                                      element['image'] == ''
                                          ? const SizedBox()
                                          : ImageWithHero(
                                              itsMe:
                                                  element['senderId'] == myID,
                                              imageUrl: element['image'],
                                              heroTag:
                                                  element['image'].toString(),
                                            ),
                                      verticalSpacer(space: 0.001),
                                      element['message'] == ''
                                          ? const SizedBox()
                                          : Container(
                                              margin:
                                                  element['senderId'] != myID
                                                      ? const EdgeInsets.only(
                                                          right: 50)
                                                      : const EdgeInsets.only(
                                                          left: 50),
                                              decoration: BoxDecoration(
                                                boxShadow: customShadow,
                                                borderRadius: element[
                                                            'image'] ==
                                                        ''
                                                    ? BorderRadius.circular(12)
                                                    : const BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(12),
                                                        bottomRight:
                                                            Radius.circular(
                                                                12)),
                                                gradient:
                                                    element['senderId'] == myID
                                                        ? primaryGradiant
                                                        : whiteGradiant,
                                              ),
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    element['senderId'] == myID
                                                        ? CrossAxisAlignment.end
                                                        : CrossAxisAlignment
                                                            .start,
                                                children: [
                                                  element['isReply'] == true
                                                      ? Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 8,
                                                                  horizontal:
                                                                      15),
                                                          decoration: BoxDecoration(
                                                              border: const Border(
                                                                  left: BorderSide(
                                                                      color:
                                                                          primaryColor,
                                                                      width:
                                                                          3)),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              color: const Color
                                                                  .fromARGB(255,
                                                                  41, 40, 40)),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              appTextGiloryBlack(
                                                                  textString: element[
                                                                          'replyOf']
                                                                      ['name']),
                                                              appTextGiloryMedium(
                                                                  textString: element[
                                                                          'replyOf']
                                                                      [
                                                                      'message'],
                                                                  isCenter:
                                                                      false)
                                                            ],
                                                          ),
                                                        )
                                                      : const SizedBox(),
                                                  Text(
                                                    element['message'],
                                                    style: TextStyle(
                                                      color:
                                                          element['senderId'] ==
                                                                  myID
                                                              ? Colors.white
                                                              : Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    final watchmage = context.watch<ImagePickerProvider>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ischatReply
              ? badges.Badge(
                  badgeStyle:
                      const badges.BadgeStyle(badgeColor: appWhiteColor),
                  position: badges.BadgePosition.topEnd(end: 10, top: 1),
                  badgeContent: InkWell(
                    onTap: () {
                      replyMessage = {};
                      setState(() {
                        ischatReply = false;
                      });
                    },
                    child: const Icon(
                      Icons.close,
                      size: 12,
                    ),
                  ),
                  child: Container(
                    width: screenWidth,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    decoration: BoxDecoration(
                        border: const Border(
                            left: BorderSide(color: primaryColor, width: 3)),
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(255, 41, 40, 40)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        appTextGiloryBlack(textString: replyMessage['name']),
                        appTextGiloryMedium(
                            textString: replyMessage['message'],
                            isCenter: false)
                      ],
                    ),
                  ),
                )
              : const SizedBox(),
          appTextField(
            controler: _textController,
            onchange: (value) {},
            hintText: "Your message..",
            keyBordType: TextInputType.text,
            maxLiness: 1,
            pefixWidgit: watchmage.postimage != null
                ? GestureDetector(
                    onTap: () {
                      context
                          .read<ImagePickerProvider>()
                          .custonImagePIcker(sourceimage: ImageSource.gallery);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      child: CircleAvatar(
                        backgroundImage: FileImage(watchmage.postimage!),
                      ),
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      context
                          .read<ImagePickerProvider>()
                          .custonImagePIcker(sourceimage: ImageSource.gallery);
                    },
                    icon: const Icon(Icons.image)),
            sufixWidgit: InkWell(
              onTap: () {
                sendMessage();
              },
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor,
                    gradient: primaryGradiant),
                child: const Icon(
                  Icons.send,
                  color: appWhiteColor,
                ),
              ),
            ),
            fieldvalivator: (value) => null,
          ),
        ],
      ),
    );
  }

  Future<void> sendMessage() async {
    final readmage = context.read<ImagePickerProvider>();

    File? selectedImage = readmage.postimage;
    readmage.clean();

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
      'image': selectedImage == null ? '' : "loading",
      'isReply': ischatReply,
      'replyOf': replyMessage
    };

    _textController.clear();
    ischatReply = false;
    setState(() {});
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
    DocumentReference messageRef = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserID)
        .collection('chat')
        .doc(chatId)
        .collection('oneToOne')
        .add(message)
        .whenComplete(() => debugPrint(''));
    debugPrint(messageRef.id.toString());

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
    DocumentReference messageRefFried = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userID)
        .collection('chat')
        .doc(chatIDForFriend)
        .collection('oneToOne')
        .add(message)
        .whenComplete(() => debugPrint(""));

    if (selectedImage != null) {
      File imageFile = File(selectedImage.path);
      String? imageUrl = await uploadImage(imageFile, widget.userID);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserID)
          .collection('chat')
          .doc(chatId)
          .collection('oneToOne')
          .doc(messageRef.id)
          .update({'image': imageUrl});

      //-------friend
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userID)
          .collection('chat')
          .doc(chatIDForFriend)
          .collection('oneToOne')
          .doc(messageRefFried.id)
          .update({'image': imageUrl});
    }
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
