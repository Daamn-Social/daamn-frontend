import 'dart:async';
import 'package:daamn/constant/exports.dart';
import 'package:firebase_core/firebase_core.dart';
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
      Key? key})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [
    ChatMessage(
      text:
          'Hello! How are you doing today? I hope everything is going well for you.',
      isMe: false,
      imageUrl: 'https://via.placeholder.com/150',
      date: DateTime.now().subtract(const Duration(minutes: 1)),
    ),
    ChatMessage(
      text: 'Hi there! I\'m doing great, thank you. How about you?',
      isMe: true,
      imageUrl: 'https://via.placeholder.com/150',
      date: DateTime.now().subtract(const Duration(minutes: 10)),
    ),
    ChatMessage(
      text:
          'I\'m doing fine, just a bit tired from work. But I\'m looking forward to the weekend.',
      isMe: false,
      imageUrl: 'https://via.placeholder.com/150',
      date: DateTime.now().subtract(const Duration(minutes: 15)),
    ),
    // Add more messages here
  ];

  final TextEditingController _textController = TextEditingController();
  // StreamController to manage the messages stream
  final StreamController<List<ChatMessage>> _messagesStreamController =
      StreamController<List<ChatMessage>>.broadcast();

// Function to get the messages stream for a specific chatId
  Stream<List<ChatMessage>> getMessagesStream(String chatId) {
    return _messagesStreamController.stream;
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
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
              SizedBox(
                child: Row(
                  children: [
                    horizontalSpacer(space: 0.02),
                    IconButton(
                        onPressed: () {},
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
              ),
              // Expanded(
              //   child: SizedBox(
              //       width: w * 0.9,
              //     child: StreamBuilder<List<ChatMessage>>(
              //         stream: getMessagesStream("chatId"),
              //         builder: (context, snapshot) {
              //           if (snapshot.connectionState == ConnectionState.waiting) {
              //             return Center(child: CircularProgressIndicator());
              //           }

              //           if (snapshot.hasError) {
              //             return Center(child: Text('Error: ${snapshot.error}'));
              //           }

              //           List<ChatMessage> messages = snapshot.data ?? [];

              //           return SizedBox();
              //         }),
              //   ),
              // ),
              Expanded(
                  child: SizedBox(
                width: w * 0.9,
                child: GroupedListView(
                  order: GroupedListOrder.DESC,
                  floatingHeader: true,
                  useStickyGroupSeparators: true,
                  elements: _messages,
                  groupBy: (element) => DateTime(
                      element.date.year, element.date.month, element.date.day),
                  groupHeaderBuilder: (element) => SizedBox(
                    height: 40,
                    child: Center(
                        child: Card(
                      color: appWhiteColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: appTextGiloryMedium(
                            textString: DateFormat.jm().format(element.date),
                            color: Colors.black),
                      ),
                    )),
                  ),
                  itemBuilder: (context, element) => Align(
                    alignment: element.isMe
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: SizedBox(
                      width: w * 0.6,
                      child: Card(
                        color: Colors.white,
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: appTextGiloryMedium(
                              isCenter: false,
                              textString: element.text,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ),
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
            //  sendMessage("text");
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

  Future<void> sendMessage(String chatId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc("BkspV0dGUsStIhRZ30lcGWvRAmm2")
        .collection('chat')
        .doc("chatID")
        .set({
      'senderId': "senderId",
      'receiverId': "receiverId",
      'message': "message",
      'timestamp': "timestamp",
      'deleted': false, // Default value
    }).whenComplete(() => debugPrint("message sended"));
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
