
//Vigenere cipher
class PolyalphabeticAlgorithm {
  bool keyValidation(String userKey) {
    return userKey.isNotEmpty;
  }

  String encode(String message, String userKey) {
    message = message.toUpperCase().replaceAll(" ", "");
    String key = _generateKey(userKey, message.length);
    String result = "";
    for (int i = 0; i < message.length; i++) {
      String x = String.fromCharCode(
          (message.codeUnitAt(i) + key.codeUnitAt(i)) % 26 + 65);
      result += x;
    }

    return result;
  }

  String decode(String message, String userKey) {
    message = message.toUpperCase().replaceAll(" ", "");
    String key = _generateKey(userKey, message.length);
    String result = "";
    for (int i = 0; i < message.length; i++) {
      String x = String.fromCharCode(
          ((message.codeUnitAt(i) - key.codeUnitAt(i) + 26) % 26) + 65);
      result += x;
    }

    return result;
  }

  String _generateKey(String userKey, int messageSize) {
    userKey = userKey.toUpperCase();
    String key = "";
    while (key.length < messageSize) {
      key += userKey;
    }
    return key.substring(0, messageSize);
  }
}
