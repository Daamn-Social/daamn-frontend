// ignore_for_file: library_private_types_in_public_api

import 'package:daamn/constant/exports.dart';
import 'package:daamn/screens/chat/chat_list.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: appBlackColor,
        body: Center(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ellipseSetting), fit: BoxFit.cover),
            ),
            child: SizedBox(
              height: h,
              width: w * 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpacer(space: 0.01),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          AppNavigator.off();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 30,
                          color: appWhiteColor,
                        ),
                      ),
                      horizontalSpacer(space: 0.02),
                      appTextGiloryBlack(
                          textString: 'Settings',
                          fontSize: 42,
                          fontweight: FontWeight.w400),
                    ],
                  ),
                  SizedBox(
                    child: appTextField(
                      controler: _searchController,
                      onchange: (value) {
                        setState(() {
                          _searchQuery = value.toLowerCase();
                        });
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
                  verticalSpacer(space: 0.01),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _filteredSettingsTiles(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _filteredSettingsTiles() {
    return [
      if (_searchQuery.isEmpty) ...[
        settingText(txt: 'Account'),

        settingTile(
          txt: "Privacy",
          ontap: () {},
        ),
        settingTile(
          txt: "Security",
          ontap: () {},
        ),
        settingTile(
          txt: "Notifications",
          ontap: () {},
        ),
        verticalSpacer(space: 0.02),
        settingText(txt: 'Matching Preferences'),
        settingTile(
          txt: "Discovery Settings",
          ontap: () {},
        ),
        settingTile(
          txt: "Connection Settings",
          ontap: () {},
        ),
        verticalSpacer(space: 0.02),
        settingText(txt: 'Communication Settings'),
        // settingTile(
        //   txt: "Chat",
        //   ontap: () {
        //     AppNavigator.to(const ChatListScreen());
        //   },
        // ),
        settingTile(
          txt: "Blocked Users",
          ontap: () {},
        ),
        verticalSpacer(space: 0.02),
        settingText(txt: 'App Settings'),
        settingTile(
          txt: "Appearance",
          ontap: () {},
        ),
        settingTile(
          txt: "Sound & Vibration",
          ontap: () {},
        ),
        verticalSpacer(space: 0.02),
        settingText(txt: 'Support & Information'),
        settingTile(
          txt: "Help Center",
          ontap: () {},
        ),
        settingTile(
          txt: "Feedback",
          ontap: () {},
        ),
        settingTile(
          txt: "About",
          ontap: () {},
        ),
        verticalSpacer(space: 0.02),
        settingText(txt: 'Subscription Settings'),
        settingTile(
          txt: "Manage Subscription",
          ontap: () {},
        ),
        settingTile(
          txt: "Purchase History",
          ontap: () {},
        ),
        verticalSpacer(space: 0.02),
        settingTile(
          txt: "Logout",
          ontap: () async {
            AppNavigator.toAndRemoveUntil(const LoginScreen());
            await FirebaseAuth.instance.signOut();
          },
        ),
        verticalSpacer(space: 0.1),
        // Add other default setting tiles here
      ] else ...[
        // Filtered setting tiles based on the search query
        ..._getFilteredSettings(),
      ],
    ];
  }

  List<Widget> _getFilteredSettings() {
    // Replace this with your actual list of settings to filter
    final List<String> settings = [
      "Logout",
      "Privacy",
      "Security",
      "Notifications",
      "Discovery Settings",
      "Connection Settings",
      //"Chat",
      "Blocked Users",
      "Appearance",
      "Sound & Vibration",
      "Help Center",
      "Feedback",
      "About",
      "Manage Subscription",
      "Purchase History",
    ];

    return settings
        .where((setting) => setting.toLowerCase().contains(_searchQuery))
        .map((setting) => settingTile(
            txt: setting,
            ontap: () {
              switch (setting) {
                case "Chat":
                  AppNavigator.to(const ChatListScreen());
                  break;
                case "Privacy":
                  // Navigate to the privacy screen
                  break;
                // Add cases for other settings
              }
            }))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

Widget settingText({required String txt}) {
  return Column(
    children: [
      appTextGiloryBlack(
          textString: txt,
          fontSize: 24,
          fontweight: FontWeight.w400,
          color: appWhiteColor),
      verticalSpacer(space: 0.01)
    ],
  );
}

Widget settingTile({required String txt, void Function()? ontap}) {
  return InkWell(
    onTap: ontap,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          appTextGiloryMedium(
              textString: txt,
              isCenter: false,
              fontSize: 20,
              fontweight: FontWeight.w400,
              color: txt == 'Logout' ? Colors.red : appWhiteColor),
          const Spacer(),
          txt == 'Logout'
              ? const SizedBox()
              : const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 20,
                ),
        ],
      ),
    ),
  );
}
