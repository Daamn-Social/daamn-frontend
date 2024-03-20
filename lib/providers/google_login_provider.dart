import 'package:daamn/constant/exports.dart';
import 'package:daamn/models/user_location_model.dart';
import 'package:daamn/services/userlocation_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future<void> googleLogin({required BuildContext context}) async {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.loading,
        backgroundColor: primaryColor,
        headerBackgroundColor: primaryColor);
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credentials
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Get the user's data
      final displayName = googleUser.displayName;
      final email = googleUser.email;
      final photoUrl = googleUser.photoUrl;

      // Save the data to Firestore under the user's UID
      final uid = userCredential.user?.uid;
      if (uid != null) {
        UserLocation? userloc = await getUserLocation();
        DocumentSnapshot<Map<String, dynamic>> user;
        if (await userExists(uid)) {
          await FirebaseFirestore.instance.collection('users').doc(uid).update({
            'lat': userloc != null ? userloc.lat : 000000,
            'lng': userloc != null ? userloc.lng : 000000,
            'addres': userloc != null ? userloc.address : "Dummy",
          });
          user = await FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .get();
        } else {
          await FirebaseFirestore.instance.collection('users').doc(uid).set({
            'userId': uid,
            'name': displayName,
            'email': email,
            'image': photoUrl,
            'lat': userloc != null ? userloc.lat : 0.00020,
            'lng': userloc != null ? userloc.lng : 0.00500,
            'addres': userloc != null ? userloc.address : "Dummy",
            'join_date': DateTime.now(),
            'online_Status': "offline",
            'last_seen': DateTime.now(),
            'userBio': [],
            'imagesList': [],
            'interests': [],
            'social_links': [
              {
                'youtube': "",
                'instagram': "",
                'snapchat': "",
                'tictok': "",
              }
            ]
          });
          user = await FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .get();
        }

        // Save user data to SharedPreferences
        final userModel = UserModel(
          userId: uid,
          name: displayName ?? '',
          email: email,
          image: photoUrl ?? '',
          lat: user['lat'], // Set default values for lng and lat
          lng: user['lng'],
          addres: user['addres'],
        );
        await saveUserData(userModel);
      }
      AppNavigator.toReplacement(const BottomBArView());
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      snaki(msg: e.toString());
    }
  }

  Future<bool> userExists(String uid) async {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return doc.exists;
  }

  Future<void> saveUserData(UserModel userModel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', FirebaseAuth.instance.currentUser!.uid);
    await prefs.setString('name', userModel.name);
    await prefs.setString('email', userModel.email);
    await prefs.setString('image', userModel.image ?? '');
    await prefs.setDouble('lng', userModel.lng);
    await prefs.setDouble('lat', userModel.lat);
    await prefs.setString('address', userModel.addres);

    debugPrint("user data saved");
  }

  Future<UserModel?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    if (userId == null) return null;

    return UserModel(
      userId: userId,
      name: prefs.getString('name') ?? '',
      email: prefs.getString('email') ?? '',
      image: prefs.getString('image') ?? '',
      lng: prefs.getDouble('lng') ?? 0,
      lat: prefs.getDouble('lat') ?? 0,
      addres: prefs.getString('address') ?? '',
    );
  }
}
