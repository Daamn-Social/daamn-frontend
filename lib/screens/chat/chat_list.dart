import 'package:daamn/constant/exports.dart';
import 'package:daamn/screens/chat/chat_screen.dart';
import 'package:daamn/screens/chat/widget/bottom_sheet.dart';
import 'package:daamn/screens/settings/settings.dart';
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
      decoration: const BoxDecoration(
          color: appBlackColor,
          image: DecorationImage(
              image: AssetImage(ellipseSetting), fit: BoxFit.cover)),

      child: Container(
        decoration: BoxDecoration(
          color: appBlackColor.withOpacity(0.7),
        ),
        child: Center(
          child: SizedBox(
            height: h,
            width: w * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpacer(space: 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    appTextGiloryBlack(
                        textString: 'Chat',
                        fontSize: 42,
                        fontweight: FontWeight.w400),
                    GestureDetector(
                      onTap: () {
                        AppNavigator.to(const SettingsScreen());
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: ImageIcon(AssetImage(nav1)),
                      ),
                    )
                  ],
                ),
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
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor,
                          gradient: primaryGradiant),
                      child: const Icon(
                        Icons.search,
                        color: appWhiteColor,
                      ),
                    ),
                    fieldvalivator: (value) => null,
                  ),
                ),
                verticalSpacer(space: 0.015),
                Expanded(
                  child: SizedBox(
                    width: w * 0.9,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('chatList')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection("chat")
                          .orderBy('time',
                              descending:
                                  true) // Sort by time in descending order
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
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

                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                width: w,
                                child: Wrap(
                                  spacing: 8.0, // spacing between each interest
                                  runSpacing:
                                      8.0, // spacing between rows of interests
                                  children: List.generate(
                                    filteredChats.length > 6
                                        ? 6
                                        : filteredChats.length,
                                    (index) => InkWell(
                                      onTap: () {
                                        AppNavigator.to(ChatScreen(
                                          userID: filteredChats[index]['id'],
                                          userName: filteredChats[index]
                                              ['name'],
                                          userImage: filteredChats[index]
                                                  ['image'] ??
                                              placeHolderNetwork,
                                        ));
                                      },
                                      onLongPress: () {
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
                                              userID: filteredChats[index]
                                                  ['id'],
                                              userName: filteredChats[index]
                                                  ['name'],
                                              userImage: filteredChats[index]
                                                      ['image'] ??
                                                  placeHolderNetwork,
                                            );
                                          },
                                        );
                                      },
                                      child: SizedBox(
                                        width: w * 0.28,
                                        height: w * 0.33,
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: w * 0.28,
                                              height: w * 0.3,
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                boxShadow: customShadow,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                gradient: blackGradiant,
                                              ),
                                              child: Container(
                                                width: w * 0.28,
                                                height: w * 0.3,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          filteredChats[index]
                                                                  ['image'] ??
                                                              placeHolderNetwork,
                                                        ),
                                                        fit: BoxFit.cover),
                                                    color: primaryColor
                                                        .withOpacity(0.3),
                                                    gradient: primaryGradiant,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    appTextGiloryBlack(
                                                        textString:
                                                            filteredChats[index]
                                                                ['name'],
                                                        color: Colors.white,
                                                        fontSize: 14),
                                                    verticalSpacer(space: 0.01)
                                                  ],
                                                ),
                                              ),
                                            ),
                                            filteredChats[index]['lastMes'] ==
                                                    ''
                                                ? const SizedBox()
                                                : Positioned(
                                                    bottom: 0,
                                                    left: 8,
                                                    child: Container(
                                                      width: w * 0.23,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8,
                                                          vertical: 2),
                                                      decoration: BoxDecoration(
                                                          color: primaryColor,
                                                          gradient:
                                                              primaryGradiant,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12)),
                                                      child: appTextGiloryBlack(
                                                          textString: getSubString(
                                                              txt: filteredChats[
                                                                      index]
                                                                  ['lastMes'],
                                                              lenght: 8),
                                                          fontSize: 10),
                                                    ),
                                                  )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              for (int i = 0;
                                  i < filteredChats.length;
                                  i++) ...{
                                verticalSpacer(space: 0.02),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        AppNavigator.to(ChatScreen(
                                          userID: filteredChats[i]['id'],
                                          userName: filteredChats[i]['name'],
                                          userImage: filteredChats[i]
                                                  ['image'] ??
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
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20),
                                                      topRight:
                                                          Radius.circular(20),
                                                    ),
                                                  ),
                                                  builder:
                                                      (BuildContext context) {
                                                    return CustomBottomSheet(
                                                      userID: filteredChats[i]
                                                          ['id'],
                                                      userName: filteredChats[i]
                                                          ['name'],
                                                      userImage: filteredChats[
                                                              i]['image'] ??
                                                          placeHolderNetwork,
                                                    );
                                                  },
                                                );
                                              },
                                              backgroundColor: primaryColor,
                                              foregroundColor: Colors.white,
                                              icon: iconDataThreedoots ??
                                                  Icons.more,
                                              padding: const EdgeInsets.all(0),
                                              label: 'More',
                                            ),
                                            SlidableAction(
                                              onPressed: (context) {
                                                deleteChat(
                                                  filteredChats[i]['id'],
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
                                            backgroundImage: NetworkImage(
                                                filteredChats[i]['image']),
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
                                                        textString:
                                                            extractFirstName(
                                                                filteredChats[i]
                                                                    ['name']),
                                                        fontSize: 22,
                                                        fontweight:
                                                            FontWeight.w400),
                                                    const Spacer(),
                                                    appTextGiloryMedium(
                                                        textString:
                                                            getTimeDifferenceString(
                                                                filteredChats[i]
                                                                    ['time']),
                                                        fontSize: 10,
                                                        fontweight:
                                                            FontWeight.w400),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: w * 0.7,
                                                child: appTextGiloryMedium(
                                                    textString: getSubString(
                                                        txt: filteredChats[i]
                                                            ['lastMes'],
                                                        lenght: 60),
                                                    fontSize: 12,
                                                    isCenter: false,
                                                    fontweight:
                                                        FontWeight.w400),
                                              )
                                            ],
                                          )
                                        ]),
                                      ),
                                    ),
                                    Container(
                                      width: w,
                                      height: 2,
                                      margin: const EdgeInsets.only(top: 15),
                                      decoration: BoxDecoration(
                                          color: primaryColor,
                                          gradient: primaryGradiant,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                    )
                                  ],
                                )
                              },

                              // ListView.builder(
                              //   itemCount: filteredChats.length,
                              //   itemBuilder: (context, index) {
                              //     var chatDocument = filteredChats[index];
                              //     return Column(
                              //       children: [
                              //         InkWell(
                              //           onTap: () {
                              //             AppNavigator.to(ChatScreen(
                              //               userID: chatDocument['id'],
                              //               userName: chatDocument['name'],
                              //               userImage:
                              //                   chatDocument['image'] ??
                              //                       placeHolderNetwork,
                              //             ));
                              //           },
                              //           child: Slidable(
                              //             // Specify a key if the Slidable is dismissible.
                              //             key: const ValueKey(0),

                              //             // The end action pane is the one at the right or the bottom side.
                              //             endActionPane: ActionPane(
                              //               motion: const ScrollMotion(),
                              //               children: [
                              //                 SlidableAction(
                              //                   onPressed: (context) {
                              //                     showModalBottomSheet(
                              //                       clipBehavior:
                              //                           Clip.antiAlias,
                              //                       context: context,
                              //                       shape:
                              //                           const RoundedRectangleBorder(
                              //                         borderRadius:
                              //                             BorderRadius.only(
                              //                           topLeft:
                              //                               Radius.circular(
                              //                                   20),
                              //                           topRight:
                              //                               Radius.circular(
                              //                                   20),
                              //                         ),
                              //                       ),
                              //                       builder: (BuildContext
                              //                           context) {
                              //                         return CustomBottomSheet(
                              //                           userID:
                              //                               chatDocument[
                              //                                   'id'],
                              //                           userName:
                              //                               chatDocument[
                              //                                   'name'],
                              //                           userImage: chatDocument[
                              //                                   'image'] ??
                              //                               placeHolderNetwork,
                              //                         );
                              //                       },
                              //                     );
                              //                   },
                              //                   backgroundColor:
                              //                       primaryColor,
                              //                   foregroundColor:
                              //                       Colors.white,
                              //                   icon: iconDataThreedoots ??
                              //                       Icons.more,
                              //                   padding:
                              //                       const EdgeInsets.all(0),
                              //                   label: 'More',
                              //                 ),
                              //                 SlidableAction(
                              //                   onPressed: (context) {
                              //                     deleteChat(
                              //                       chatDocument['id'],
                              //                     );
                              //                   },
                              //                   backgroundColor: Colors.red,
                              //                   foregroundColor:
                              //                       Colors.white,
                              //                   icon: Icons.delete,
                              //                   padding:
                              //                       const EdgeInsets.all(0),
                              //                   label: 'Delete',
                              //                 ),
                              //               ],
                              //             ),

                              //             child: Row(children: [
                              //               CircleAvatar(
                              //                 radius: 25,
                              //                 backgroundImage: NetworkImage(
                              //                     chatDocument['image']),
                              //               ),
                              //               horizontalSpacer(space: 0.02),
                              //               Column(
                              //                 crossAxisAlignment:
                              //                     CrossAxisAlignment.start,
                              //                 children: [
                              //                   SizedBox(
                              //                     width: w * 0.7,
                              //                     child: Row(
                              //                       children: [
                              //                         appTextGiloryMedium(
                              //                             textString:
                              //                                 extractFirstName(
                              //                                     chatDocument[
                              //                                         'name']),
                              //                             fontSize: 22,
                              //                             fontweight:
                              //                                 FontWeight
                              //                                     .w400),
                              //                         const Spacer(),
                              //                         appTextGiloryMedium(
                              //                             textString:
                              //                                 getTimeDifferenceString(
                              //                                     chatDocument[
                              //                                         'time']),
                              //                             fontSize: 10,
                              //                             fontweight:
                              //                                 FontWeight
                              //                                     .w400),
                              //                       ],
                              //                     ),
                              //                   ),
                              //                   SizedBox(
                              //                     width: w * 0.7,
                              //                     child: appTextGiloryMedium(
                              //                         textString: getSubString(
                              //                             txt: chatDocument[
                              //                                 'lastMes'],
                              //                             lenght: 60),
                              //                         fontSize: 12,
                              //                         isCenter: false,
                              //                         fontweight:
                              //                             FontWeight.w400),
                              //                   )
                              //                 ],
                              //               )
                              //             ]),
                              //           ),
                              //         ),
                              //         const Divider(
                              //           color: primaryColor,
                              //         )
                              //       ],
                              //     );
                              //   },
                              // )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // ),
    );
  }
}
