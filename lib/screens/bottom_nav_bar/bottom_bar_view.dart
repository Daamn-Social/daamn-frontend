import 'package:daamn/screens/home/home_screen.dart';
import 'package:daamn/screens/profile/profile.dart';
import 'package:daamn/screens/settings/settings.dart';
import '../../../constant/exports.dart';

class BottomBArView extends StatefulWidget {
  const BottomBArView({super.key});

  @override
  State<BottomBArView> createState() => _BottomBArViewState();
}

class _BottomBArViewState extends State<BottomBArView> {
  final pages = [
    const SettingsScreen(),
    const HomeScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final mywatch = context.watch<BottomNavBarProvider>();
    final myread = context.read<BottomNavBarProvider>();
    final h = MediaQuery.of(context).size.height;
    //  final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scafoldBg,
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
            image:
                DecorationImage(image: AssetImage(bgImage), fit: BoxFit.cover)
            // gradient: RadialGradient(
            //   radius: h * 0.001,
            //   colors: const [
            //     Color(0xff4d477f),
            //     Color(0xff0a0b0f),
            //   ],
            // ),
            ),
        child: Column(
          children: [
            SizedBox(height: h, child: pages[mywatch.pageIndex]),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                myread.updatePageIndex(value: 0);
              },
              child: Container(
                margin:
                    EdgeInsets.only(bottom: mywatch.pageIndex == 0 ? 12 : 0),
                decoration: BoxDecoration(
                    color: mywatch.pageIndex == 0 ? primaryColor : transparent,
                    shape: BoxShape.circle),
                height: mywatch.pageIndex == 0 ? 90 : 70,
                width: 50,
                child: Center(
                  child: ImageIcon(
                    const AssetImage(
                      nav1,
                    ),
                    color:
                        mywatch.pageIndex == 0 ? appWhiteColor : appWhiteColor,
                    size: mywatch.pageIndex == 0 ? 26 : 25,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                myread.updatePageIndex(value: 1);
              },
              child: Container(
                margin:
                    EdgeInsets.only(bottom: mywatch.pageIndex == 1 ? 12 : 0),
                decoration: BoxDecoration(
                    color: mywatch.pageIndex == 1 ? primaryColor : transparent,
                    shape: BoxShape.circle),
                height: mywatch.pageIndex == 1 ? 90 : 70,
                width: 50,
                child: Center(
                  child: ImageIcon(
                    const AssetImage(
                      nav2,
                    ),
                    color:
                        mywatch.pageIndex == 1 ? appWhiteColor : appWhiteColor,
                    size: mywatch.pageIndex == 1 ? 30 : 26,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                myread.updatePageIndex(value: 2);
              },
              child: Container(
                margin:
                    EdgeInsets.only(bottom: mywatch.pageIndex == 2 ? 12 : 0),
                decoration: BoxDecoration(
                    color: mywatch.pageIndex == 2 ? primaryColor : transparent,
                    shape: BoxShape.circle),
                height: mywatch.pageIndex == 2 ? 90 : 70,
                width: 50,
                child: Center(
                  child: ImageIcon(
                    const AssetImage(
                      nav3,
                    ),
                    color:
                        mywatch.pageIndex == 2 ? appWhiteColor : appWhiteColor,
                    size: mywatch.pageIndex == 2 ? 30 : 26,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
