import 'package:daamn/constant/exports.dart';
import 'package:daamn/firebase_options.dart';
import 'package:daamn/providers/get_user_data.dart';
import 'package:daamn/providers/shared/image_picker_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseBackGroundMessages);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

//notification top level functions
@pragma('vm:entry-point')
Future<void> _firebaseBackGroundMessages(RemoteMessage message) async {}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomNavBarProvider>(
            create: (_) => BottomNavBarProvider()),
        ChangeNotifierProvider<GoogleSignInProvider>(
            create: (_) => GoogleSignInProvider()),
        ChangeNotifierProvider<GetUserDataProvider>(
            create: (_) => GetUserDataProvider()),
        ChangeNotifierProvider<ImagePickerProvider>(
            create: (_) => ImagePickerProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: scaffoldMessengerKey,
        navigatorKey: AppNavigator.navigatorKey,
        theme:
            ThemeData(splashColor: primaryColor, colorSchemeSeed: primaryColor),
        title: 'Daamn',
        home: Consumer<BottomNavBarProvider>(
          builder: (context, userProvider, _) {
            return FirebaseAuth.instance.currentUser != null
                ? const BottomBArView()
                : const LoginScreen();
          },
        ),
      ),
    );
  }
}
