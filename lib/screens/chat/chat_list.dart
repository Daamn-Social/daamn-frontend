import 'package:daamn/constant/exports.dart';
import 'package:daamn/screens/chat/chat_screen.dart';
import 'package:daamn/screens/chat/widget/bottom_sheet.dart';
import 'package:daamn/services/firebase.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final TextEditingController _searchController = TextEditingController();

  IconData? iconDataThreedoots;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Container(
      height: h,
      width: w,
      padding: const EdgeInsets.symmetric(horizontal: 0.05),

      child: Center(
        child: SizedBox(
          height: h,
          width: w * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpacer(space: 0.01),
              appTextGiloryBlack(
                  textString: 'Chat',
                  fontSize: 42,
                  fontweight: FontWeight.w400),
              SizedBox(
                child: appTextField(
                  controler: _searchController,
                  onchange: (value) {
                    setState(() {});
                  },
                  hintText: "Search..",
                  keyBordType: TextInputType.text,
                  maxLiness: 1,
                  sufixWidgit: Container(
                    margin: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryColor,
                    ),
                    child: const Icon(
                      Icons.search,
                      color: appWhiteColor,
                    ),
                  ),
                  fieldvalivator: (value) => null,
                ),
              ),
              verticalSpacer(space: 0.015),
              Image.asset('assets/image/chatimage.png'),
              Expanded(
                child: SizedBox(
                  width: w * 0.9,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('chatList')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("chat")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }

                      var filteredChats = snapshot.data!.docs
                          .where((doc) => doc['name']
                              .toString()
                              .toLowerCase()
                              .contains(_searchController.text.toLowerCase()))
                          .toList();

                      if (filteredChats.isEmpty) {
                        return const Center(
                          child: Text('No chat',
                              style: TextStyle(color: appWhiteColor)),
                        );
                      }

                      return ListView.builder(
                        itemCount: filteredChats.length,
                        itemBuilder: (context, index) {
                          var chatDocument = filteredChats[index];
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  AppNavigator.to(ChatScreen(
                                    userID: chatDocument['id'],
                                    userName: chatDocument['name'],
                                    userImage: chatDocument['image'] ??
                                        placeHolderNetwork,
                                  ));
                                },
                                child: Slidable(
                                  // Specify a key if the Slidable is dismissible.
                                  key: const ValueKey(0),

                                  // The end action pane is the one at the right or the bottom side.
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          showModalBottomSheet(
                                            clipBehavior: Clip.antiAlias,
                                            context: context,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20),
                                              ),
                                            ),
                                            builder: (BuildContext context) {
                                              return CustomBottomSheet(
                                                userID: chatDocument['id'],
                                                userName: chatDocument['name'],
                                                userImage:
                                                    chatDocument['image'] ??
                                                        placeHolderNetwork,
                                              );
                                            },
                                          );
                                        },
                                        backgroundColor: primaryColor,
                                        foregroundColor: Colors.white,
                                        icon: iconDataThreedoots ?? Icons.more,
                                        padding: const EdgeInsets.all(0),
                                        label: 'More',
                                      ),
                                      SlidableAction(
                                        onPressed: (context) {
                                          deleteChat(
                                            chatDocument['id'],
                                          );
                                        },
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        padding: const EdgeInsets.all(0),
                                        label: 'Delete',
                                      ),
                                    ],
                                  ),

                                  child: Row(children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundImage:
                                          NetworkImage(chatDocument['image']),
                                    ),
                                    horizontalSpacer(space: 0.02),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: w * 0.7,
                                          child: Row(
                                            children: [
                                              appTextGiloryMedium(
                                                  textString: extractFirstName(
                                                      chatDocument['name']),
                                                  fontSize: 22,
                                                  fontweight: FontWeight.w400),
                                              const Spacer(),
                                              appTextGiloryMedium(
                                                  textString:
                                                      getTimeDifferenceString(
                                                          chatDocument['time']),
                                                  fontSize: 10,
                                                  fontweight: FontWeight.w400),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: w * 0.7,
                                          child: appTextGiloryMedium(
                                              textString: getSubString(
                                                  txt: chatDocument['lastMes'],
                                                  lenght: 60),
                                              fontSize: 12,
                                              isCenter: false,
                                              fontweight: FontWeight.w400),
                                        )
                                      ],
                                    )
                                  ]),
                                ),
                              ),
                              const Divider(
                                color: primaryColor,
                              )
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}
