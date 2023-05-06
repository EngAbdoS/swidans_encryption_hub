class AutoKeyAlgorithm {
  bool keyValidation(String userKey) {
    return userKey.length == 1;
  }

  String encode(String message, String userKey) {
    message = message.toUpperCase().replaceAll(" ", " ");
    userKey = userKey.toUpperCase();

    String key = userKey + message;

    String result = "";
    for (int i = 0; i < message.length; i++) {
      int messageCharCode = message.codeUnitAt(i);
      int keyCharCode = key.codeUnitAt(i);
      result += String.fromCharCode(
          (((messageCharCode + keyCharCode - 2 * 'A'.codeUnitAt(0)) % 26) +
              'A'.codeUnitAt(0)));
    }

    return result;
  }

  String decode(String message, String userKey) {
    message = message.toUpperCase().replaceAll(" ", "");
    userKey = userKey.toUpperCase();

    String key = userKey;
    for (int i = 0; i < message.length - userKey.length; i++) {
      int messageCharCode = message.codeUnitAt(i);

      key += String.fromCharCode(
          (((messageCharCode - key.codeUnitAt(i) + 26) % 26) +
              'A'.codeUnitAt(0)));
    }

    String result = "";
    for (int i = 0; i < message.length; i++) {
      int messageCharCode = message.codeUnitAt(i);

      result += String.fromCharCode(
          (((messageCharCode - key.codeUnitAt(i) + 26) % 26) +
              'A'.codeUnitAt(0)));
    }

    return result;
  }
}
