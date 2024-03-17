import 'exports.dart';

class DummyUser {
  String name;
  String profile;
  Color color;

  DummyUser({
    required this.name,
    required this.profile,
    required this.color,
  });
}

List<DummyUser> users = [
  DummyUser(name: "Jonipal", profile: p1, color: Colors.redAccent),
  DummyUser(name: "Ridwan", profile: p2, color: Colors.blueAccent),
  DummyUser(name: "Valtar", profile: p3, color: Colors.greenAccent),
  DummyUser(name: "Dwyne", profile: p4, color: Colors.pinkAccent),
  DummyUser(name: "katrine", profile: p5, color: Colors.orangeAccent),
  DummyUser(name: "Koabnopi", profile: p6, color: Colors.cyanAccent),
];

class UserScreenPositionclass {
  double top;
  double left;
  UserScreenPositionclass({required this.top, required this.left});
}

List<UserScreenPositionclass> usersLoationsList = [
  UserScreenPositionclass(
      top: MediaQuery.of(scaffoldMessengerKey.currentContext!).size.height *
          0.35,
      left: MediaQuery.of(scaffoldMessengerKey.currentContext!).size.width *
          0.1), //1
  UserScreenPositionclass(
      top:
          MediaQuery.of(scaffoldMessengerKey.currentContext!).size.height * 0.3,
      left: MediaQuery.of(scaffoldMessengerKey.currentContext!).size.width *
          0.3), //2
  UserScreenPositionclass(
      top:
          MediaQuery.of(scaffoldMessengerKey.currentContext!).size.height * 0.3,
      left: MediaQuery.of(scaffoldMessengerKey.currentContext!).size.width *
          0.5), //3
  UserScreenPositionclass(
      top: MediaQuery.of(scaffoldMessengerKey.currentContext!).size.height *
          0.35,
      left: MediaQuery.of(scaffoldMessengerKey.currentContext!).size.width * //4
          0.75),
  UserScreenPositionclass(
      top: MediaQuery.of(scaffoldMessengerKey.currentContext!).size.height *
          0.45,
      left: MediaQuery.of(scaffoldMessengerKey.currentContext!).size.width *
          0.65), //5
  UserScreenPositionclass(
      top: MediaQuery.of(scaffoldMessengerKey.currentContext!).size.height *
          0.45,
      left: MediaQuery.of(scaffoldMessengerKey.currentContext!).size.width *
          0.15), //6
  UserScreenPositionclass(
      top:
          MediaQuery.of(scaffoldMessengerKey.currentContext!).size.height * 0.5,
      left: MediaQuery.of(scaffoldMessengerKey.currentContext!).size.width *
          0.8), //7
  UserScreenPositionclass(
      top: MediaQuery.of(scaffoldMessengerKey.currentContext!).size.height *
          0.55,
      left: MediaQuery.of(scaffoldMessengerKey.currentContext!).size.width *
          0.2), //8
  UserScreenPositionclass(
      top: MediaQuery.of(scaffoldMessengerKey.currentContext!).size.height *
          0.58,
      left: MediaQuery.of(scaffoldMessengerKey.currentContext!).size.width *
          0.4), //9
  UserScreenPositionclass(
      top: MediaQuery.of(scaffoldMessengerKey.currentContext!).size.height *
          0.55,
      left: MediaQuery.of(scaffoldMessengerKey.currentContext!).size.width *
          0.6), //10
];
