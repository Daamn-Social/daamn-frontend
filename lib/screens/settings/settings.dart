import 'package:daamn/constant/exports.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Center(
      child: SizedBox(
        height: h,
        width: w * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpacer(space: 0.04),
            appText(
                textString: 'Settings',
                fontSize: 42,
                fontweight: FontWeight.w400),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                AppNavigator.toAndRemoveUntil(const LoginScreen());
              },
              child: const Text('Sign Out'),
            )
          ],
        ),
      ),
    );
  }
}
