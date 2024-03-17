bool emailvalidator(email) {
  if (RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
      .hasMatch(email)) {
    return true;
  }
  return false;
}

bool urlvalidator(url) {
  if (RegExp(
    r'^(http(s)?:\/\/)?(www\.)?[a-zA-Z0-9-_\.]+\.[a-zA-Z]{2,4}\/?([\w\/\-?=%.&=]+)?$',
  ).hasMatch(url)) {
    return true;
  }
  return false;
}

bool durationValidater(url) {
  if (RegExp(
    r'^\d{1,2}:\d{1,2}$',
  ).hasMatch(url)) {
    return true;
  }
  return false;
}
