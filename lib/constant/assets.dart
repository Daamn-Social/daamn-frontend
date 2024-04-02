//----------------app logo

const String placeHolderNetwork = 'https://via.placeholder.com/150';
const String appLogo = 'assets/logo/Logo.png';

//-------- splash

const String splashImg = 'assets/image/Splash.png';
const String bgImage = 'assets/image/Bg.png';
const String elipces = 'assets/image/Ellipses.png';
const String ellipseSetting = 'assets/image/EllipseSetting.png';

//--------------- nav icon

const String nav1 = 'assets/icon/navIcon/1.png';
const String nav2 = 'assets/icon/navIcon/2.png';
const String nav3 = 'assets/icon/navIcon/3.png';

//--------------- profile

const String p1 = 'assets/image/profile/dp2.jpg';
const String p2 = 'assets/image/profile/dp3.jpg';
const String p3 = 'assets/image/profile/dp1.jpeg';
const String p4 = 'assets/image/profile/dp5.jpeg';
const String p5 = 'assets/image/profile/dp6.jpg';
const String p6 = 'assets/image/profile/dp7.jpg';
const String p7 = 'assets/image/profile/dp8.jpg';

const String googleLogo = 'assets/icon/navIcon/google.png';

List profileImageList = [p1, p2, p3, p4, p5];

List<String> homePageImageList = [
  'https://firebasestorage.googleapis.com/v0/b/safar-e-kalam.appspot.com/o/RakuCk%2Fhome%20Images%2F1.jpg?alt=media&token=d5a0a299-9d2e-4b59-bd3b-d5f3ac0d949f',
  'https://firebasestorage.googleapis.com/v0/b/safar-e-kalam.appspot.com/o/RakuCk%2Fhome%20Images%2F2.jpg?alt=media&token=e0350c25-7597-4fba-b953-c490be782669',
  'https://firebasestorage.googleapis.com/v0/b/safar-e-kalam.appspot.com/o/RakuCk%2Fhome%20Images%2F3.jpg?alt=media&token=6e615629-6f8c-437a-bde8-de6b837dafe8',
  'https://firebasestorage.googleapis.com/v0/b/safar-e-kalam.appspot.com/o/RakuCk%2Fhome%20Images%2F4.jpg?alt=media&token=009f8432-011b-4f2a-b93e-d47f59b75cbf',
  'https://firebasestorage.googleapis.com/v0/b/safar-e-kalam.appspot.com/o/RakuCk%2Fhome%20Images%2F5.jpg?alt=media&token=3cbe211d-dcc5-47b4-9fbd-a0dbf1a09ee6',
  'https://firebasestorage.googleapis.com/v0/b/safar-e-kalam.appspot.com/o/RakuCk%2Fhome%20Images%2F6.jpg?alt=media&token=9d3b325b-6cce-4e0a-9419-f40a67259ad7',
];

String youtube = 'assets/icon/social/4.png';
String instagram = 'assets/icon/social/2.png';
String snapchat = 'assets/icon/social/1.png';
String tictok = 'assets/icon/social/3.png';

String messageicon = 'assets/icon/message.png';
String threeDotsIcon = 'assets/icon/dots.png';

class SocialIcon {
  final String name;
  final String imagePath;

  SocialIcon({required this.name, required this.imagePath});
}

List<SocialIcon> socialIcons = [
  SocialIcon(name: 'snapChat', imagePath: snapchat),
  SocialIcon(name: 'instaGram', imagePath: instagram),
  SocialIcon(name: 'tiktok', imagePath: tictok),
  SocialIcon(name: 'twitterX', imagePath: 'assets/icon/social/x.png'),
  SocialIcon(name: 'tOld', imagePath: 'assets/icon/social/told.png'),
  SocialIcon(name: 'beReal', imagePath: 'assets/icon/social/bereal.png'),
  SocialIcon(name: 'Pinterest', imagePath: 'assets/icon/social/pintrest.png'),
  SocialIcon(name: 'facebook', imagePath: 'assets/icon/social/fb.png'),
  //----------------------------------------------------------------
  SocialIcon(name: 'whatsApp', imagePath: 'assets/icon/social/9.png'),
  SocialIcon(name: 'teligram', imagePath: 'assets/icon/social/10.png'),
  SocialIcon(name: 'line', imagePath: 'assets/icon/social/11.png'),
  SocialIcon(name: 'vChat', imagePath: 'assets/icon/social/12.png'),
  //----------------------------------------------------------------
  SocialIcon(name: 'linkdin', imagePath: 'assets/icon/social/13.png'),
  SocialIcon(name: 'victory', imagePath: 'assets/icon/social/14.png'),
  //----------------------------------------------------------------
  SocialIcon(name: 'vid1', imagePath: 'assets/icon/social/15.png'),
  SocialIcon(name: 'vid2', imagePath: 'assets/icon/social/16.png'),
  SocialIcon(name: 'vid3', imagePath: 'assets/icon/social/17.png'),
  //----------------------------------------------------------------
  SocialIcon(name: 'music1', imagePath: 'assets/icon/social/18.png'),
  SocialIcon(name: 'music2', imagePath: 'assets/icon/social/19.png'),
  SocialIcon(name: 'music3', imagePath: 'assets/icon/social/20.png'),
  SocialIcon(name: 'music4', imagePath: 'assets/icon/social/21.png'),
  //----------------------------------------------------------------
  SocialIcon(name: 'g1', imagePath: 'assets/icon/social/22.png'),
  SocialIcon(name: 'g2', imagePath: 'assets/icon/social/23.png'),
  SocialIcon(name: 'g3', imagePath: 'assets/icon/social/24.png'),
  SocialIcon(name: 'g4', imagePath: 'assets/icon/social/25.png'),
  SocialIcon(name: 'g5', imagePath: 'assets/icon/social/26.png'),
  //----------------------------------------------------------------
  SocialIcon(name: 'art1', imagePath: 'assets/icon/social/30.png'),
  SocialIcon(name: 'art2', imagePath: 'assets/icon/social/27.png'),
  SocialIcon(name: 'art3', imagePath: 'assets/icon/social/28.png'),
  SocialIcon(name: 'art4', imagePath: 'assets/icon/social/29.png'),
//----------------------------------------------------------------
  SocialIcon(name: 'code1', imagePath: 'assets/icon/social/31.png'),
  SocialIcon(name: 'code2', imagePath: 'assets/icon/social/32.png'),
  SocialIcon(name: 'code3', imagePath: 'assets/icon/social/33.png'),
  SocialIcon(name: 'code4', imagePath: 'assets/icon/social/34.png'),
  SocialIcon(name: 'code5', imagePath: 'assets/icon/social/35.png'),
  SocialIcon(name: 'code6', imagePath: 'assets/icon/social/36.png'),
  SocialIcon(name: 'code7', imagePath: 'assets/icon/social/37.png'),
];

String? getSocialIconPath(String name) {
  return socialIcons
      .firstWhere((icon) => icon.name == name,
          orElse: () => SocialIcon(name: '', imagePath: ''))
      .imagePath;
}
