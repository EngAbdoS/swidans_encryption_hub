class PlayfairAlgorithm {
  bool keyValidation(String userKey) {
    return RegExp(r'^[A-Za-z]+$').hasMatch(userKey);
  }

  String encode(String message, String userKey) {
    message = message.replaceAll(" ", "").replaceAll("j", "i").toLowerCase();
    List<String> keyList = _generateKey(userKey);
    List<String> pairs = _divideIntoPairs(message);
    String result = "";
    for (String pair in pairs) {
      String encodedPair = _encodePair(pair, keyList);
      result += encodedPair;
    }

    return result;
  }

  String decode(String message, String userKey) {
    message = message.replaceAll(" ", "").replaceAll("j", "i").toLowerCase();
    List<String> keyList = _generateKey(userKey);
    List<String> pairs = _divideIntoPairs(message);

    String result = "";
    for (String pair in pairs) {
      String decodedPair = _decodePair(pair, keyList);
      result += decodedPair;
    }

    List<String> resultList = result.split("");
    if (resultList.length % 2 == 0 && resultList.last == "z") {
      resultList.removeLast();
    }
    for (int i = 0; i < resultList.length - 2; i++) {
      if (resultList[i] == resultList[i + 2] && resultList[i + 1] == "x") {
        resultList.removeAt(i + 1);
      }
    }

    result = resultList.join();
    return result;
  }

  List<String> _divideIntoPairs(String message) {
    List<String> pairs = [];
    for (int i = 0; i < message.length; i += 2) {
      if (i == message.length - 1) {
        pairs.add(message[i] + 'z');
      } else if (message[i] == message[i + 1]) {
        pairs.add(message[i] + 'x');
        i--;
      } else {
        pairs.add(message[i] + message[i + 1]);
      }
    }
    return pairs;
  }

  String _encodePair(String pair, List<String> keyList) {
    String result = "";
    int pos1 = keyList.indexOf(pair[0]);
    int pos2 = keyList.indexOf(pair[1]);
    int row1 = pos1 ~/ 5, col1 = pos1 % 5, row2 = pos2 ~/ 5, col2 = pos2 % 5;

    if (row1 == row2) {
      result += keyList[row1 * 5 + (col1 + 1) % 5];
      result += keyList[row2 * 5 + (col2 + 1) % 5];
    } else if (col1 == col2) {
      result += keyList[((row1 + 1) % 5) * 5 + col1];
      result += keyList[((row2 + 1) % 5) * 5 + col2];
    } else {
      result += keyList[row1 * 5 + col2];
      result += keyList[row2 * 5 + col1];
    }
    return result;
  }

  String _decodePair(String pair, List<String> keyList) {
    int pos1 = keyList.indexOf(pair[0]);
    int pos2 = keyList.indexOf(pair[1]);
    int row1 = pos1 ~/ 5, col1 = pos1 % 5, row2 = pos2 ~/ 5, col2 = pos2 % 5;

    String result = "";
    if (row1 == row2) {
      result += keyList[row1 * 5 + (col1 + 4) % 5];
      result += keyList[row2 * 5 + (col2 + 4) % 5];
    } else if (col1 == col2) {
      result += keyList[((row1 + 4) % 5) * 5 + col1];
      result += keyList[((row2 + 4) % 5) * 5 + col2];
    } else {
      result += keyList[row1 * 5 + col2];
      result += keyList[row2 * 5 + col1];
    }

    return result;
  }

  List<String> _generateKey(String userKey) {
    Set<String> keySet = {};
    userKey = userKey.replaceAll(" ", "").toLowerCase().replaceAll("j", "i");
    userKey.split("").toSet().forEach((element) {
      keySet.add(element);
    });
    for (var element in alphabetSet) {
      keySet.add(element);
    }

    return keySet.toList();
  }
}

Set<String> alphabetSet = {
  "a",
  "b",
  "c",
  "d",
  "e",
  "f",
  "g",
  "h",
  "i",
  //"j",
  "k",
  "l",
  "m",
  "n",
  "o",
  "p",
  "q",
  "r",
  "s",
  "t",
  "u",
  "v",
  "w",
  "x",
  "y",
  "z"
};
