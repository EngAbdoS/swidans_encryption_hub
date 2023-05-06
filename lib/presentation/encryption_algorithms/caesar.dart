// true => add key   en
// true =>user add key  de

import 'dart:math';

class CaesarAlgorithm {
  int userGeneratedKey = 0;

  bool keyValidation(String userKey) {
    if (userKey == null) {
      return false;
    }
    if (double.tryParse(userKey) != null) {
      return int.parse(userKey) >= 0 && int.parse(userKey) <= 25;
    }

    return false;
  }

  String encode(String message, bool generateKey, String userKey) {
    int key = generateKey ? int.parse(userKey) : _generateKey();
    String result = "";
    for (int i = 0; i < message.length; i++) {
      result += message[i] != ""
          ? String.fromCharCode(message.codeUnitAt(i) + key)
          : "";
    }

    return result;
  }

  String decode(String message, bool generateKey, String userKey) {
    int key = generateKey ? int.parse(userKey) : _generateKey();
    String result = "";
    for (int i = 0; i < message.length; i++) {
      result += message[i] != ""
          ? String.fromCharCode(message.codeUnitAt(i) - key)
          : "";
    }

    return result;
  }

  int _generateKey() {
    userGeneratedKey = Random().nextInt(25);

    return userGeneratedKey;
  }
}
