import 'dart:math';

class RealFenceAlgorithm {
  int userGeneratedKey = 0;

  bool keyValidation(String userKey, String message) {
    return (double.tryParse(userKey) != null) &&
        userKey.isNotEmpty &&
        int.parse(userKey) < message.length &&
        int.parse(userKey) > 1;
  }

  String encode(String message, bool generateKey, String userKey) {
    int key = generateKey ? int.parse(userKey) : _generateKey(message.length);
    List<List<String>> rail =
        List.generate(key, (_) => List.generate(message.length, (_) => '\n'));

    //  List<List<String>> rail =
    //      List.generate(key, (_) => List.filled(message.length, '\n'));

    bool dirDown = false;
    int row = 0, col = 0;
    for (int i = 0; i < message.length; i++) {
      if (row == 0 || row == key - 1) {
        dirDown = !dirDown;
      }
      rail[row][col++] = message[i];
      row += dirDown ? 1 : -1;
    }

    String result = '';
    rail.forEach((row) => result += row.where((char) => char != '\n').join());
    print(key);
    print(result);
    return result;
  }

  String decode(String message, String userKey) {
    int key = int.parse(userKey);

    List<List<String>> rail =
        List.generate(key, (_) => List.filled(message.length, '\n'));

    bool dirDown = false;
    int row = 0, col = 0;
    for (int i = 0; i < message.length; i++) {
      if (row == 0) {
        dirDown = true;
      }
      if (row == key - 1) {
        dirDown = false;
      }
      rail[row][col++] = '*';

      row += dirDown ? 1 : -1;
    }
    int index = 0;
    for (int i = 0; i < key; i++) {
      for (int j = 0; j < message.length; j++) {
        if (rail[i][j] == '*' && index < message.length) {
          rail[i][j] = message[index++];
        }
      }
    }

    String result = '';
    dirDown = false;
    row = 0;
    col = 0;
    for (int i = 0; i < message.length; i++) {
      if (row == 0) {
        dirDown = true;
      }
      if (row == key - 1) {
        dirDown = false;
      }

      if (rail[row][col] != '*') {
        result += rail[row][col++];
      }

      row += dirDown ? 1 : -1;
    }

    return result;
  }

  int _generateKey(int messageLength) {
    userGeneratedKey = Random().nextInt(messageLength - 1) + 1;

    return userGeneratedKey;
  }
}
