import 'dart:math';

Random _random = Random();

double getRandomSize(double width) {
  double randomWidth1 = _random.nextDouble() * (width - 80);

  double randomWidth2 = _random.nextDouble() * (width - 80);

  return (randomWidth1 * randomWidth2) / randomWidth2;
}

getRandonheight(double height, int index, int lenght) {
  double h = height * ((1 / (lenght + 2))) * (index + 1);
  if (h > (height / 2) - 80 && h < (height / 2) + 80) {
    if (h > (height / 2) - 100) {
      return h + 80;
    } else {
      return h - 80;
    }
  } else if (h > height * 0.8) {
    return _random.nextDouble() * (height * 0.1);
  }
  return h;
}

String extractFirstName(String fullName) {
  List<String> names = fullName.split(' ');
  if (names.isNotEmpty) {
    return names.first;
  }
  return '';
}
