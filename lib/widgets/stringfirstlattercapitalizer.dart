String capitalizeString({required String s}) {
  if (s != "") {
    return s[0].toUpperCase() + s.substring(1);
  }
  return s;
}
