// ignore_for_file: must_be_immutable

import 'package:daamn/constant/exports.dart';
import 'package:daamn/providers/streams_provider.dart';

class ChatMainHeader extends StatelessWidget {
  final String userID;
  final String userName;
  final String userImage;
  ChatMainHeader(
      {required this.userID,
      required this.userImage,
      required this.userName,
      super.key});

  String status = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<DataStreamProvider>(
      builder: (context, userProvider, _) {
        return StreamBuilder<DocumentSnapshot>(
          stream: userProvider.userStream,
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return chatHeader(img: '', name: userName, status: status);
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return chatHeader(img: '', name: userName, status: status);
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            status = snapshot.data!['online_Status'];
            return Container(
              decoration: BoxDecoration(
                gradient: primaryGradiant,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
              ),
              child: Column(
                children: [
                  verticalSpacer(space: 0.06),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
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
                          ),
                        ),
                        const Spacer(),
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            userImage != ''
                                ? userImage
                                : 'https://via.placeholder.com/150',
                          ),
                        ),
                        horizontalSpacer(space: 0.02),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            appTextGiloryBlack(
                              textString: snapshot.data!['name'],
                              isCenter: false,
                            ),
                            snapshot.data!['online_Status'] == 'Offline'
                                ? appTextGiloryMedium(
                                    textString: "Seen " +
                                        getTimeDifferenceString(
                                            snapshot.data!['last_seen']),
                                    fontSize: 10,
                                  )
                                : appTextGiloryMedium(
                                    textString: snapshot.data!['online_Status'],
                                    fontSize: 10,
                                  ),
                          ],
                        ),
                        horizontalSpacer(space: 0.02),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: ImageIcon(
                            AssetImage(threeDotsIcon),
                            color: appWhiteColor,
                          ),
                        ),
                        horizontalSpacer(space: 0.02),
                      ],
                    ),
                  ),
                  verticalSpacer(space: 0.01),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

Widget chatHeader(
    {required String img, required String name, required String status}) {
  return Container(
    decoration: BoxDecoration(
        gradient: primaryGradiant,
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25))),
    child: Column(
      children: [
        verticalSpacer(space: 0.06),
        SizedBox(
          width: screenWidth,
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
              const Spacer(),
              CircleAvatar(
                backgroundImage: NetworkImage(img),
              ),
              horizontalSpacer(space: 0.02),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appTextGiloryBlack(textString: name, isCenter: false),
                  appTextGiloryMedium(textString: status, fontSize: 10)
                ],
              ),
              horizontalSpacer(space: 0.02),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: ImageIcon(
                  AssetImage(threeDotsIcon),
                  color: appWhiteColor,
                ),
              ),
              horizontalSpacer(space: 0.02),
            ],
          ),
        ),
        verticalSpacer(space: 0.01),
      ],
    ),
  );
}
