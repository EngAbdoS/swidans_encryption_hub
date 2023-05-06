// true => add key   en
// true =>user add key  de

class MonoalphabeticAlgorithm {
  String userGeneratedKey = "";
  Map<String, String> encodeHash = {}; //مع الانتر رن استارت و الميثود
  Map<String, String> decodeHash = {};

  void _start(String userKey, bool generateKey) {
    if (!generateKey) {
      _generateKey();
      for (int i = 0; i < keyList.length; i++) {
        encodeHash[alphabetList[i]] = keyList[i];
        decodeHash[keyList[i]] = alphabetList[i];
      }
    } else {
      List<String> userKeyList = userKey.split("");
      for (int i = 0; i < userKeyList.length; i++) {
        encodeHash[alphabetList[i]] = userKeyList[i];
        decodeHash[userKeyList[i]] = alphabetList[i];
      }
    }
  }

//maps done
  bool keyValidation(String userKey) {
    return(userKey.split("").toSet().length==26&&userKey.length == 26&&RegExp(r'^[A-Za-z]+$').hasMatch(userKey));


  }

  String encode(String message, bool generateKey, String userKey) {
    _start(userKey, generateKey);
    String result = "";

    message.split("").forEach((ch) => result += encodeHash[ch] ?? ch);
    return result;
  }

  decode(String message, bool generateKey, String userKey) {
    decodeHash.isEmpty ? _start(userKey, generateKey) : {};
    String result = "";
    message.split("").forEach((ch) => result += decodeHash[ch] ?? ch);
    return result;
  }

  List<String> _generateKey() {
    keyList.shuffle();
    _keyToString(keyList);
    return keyList;
  }

  void _keyToString(List<String> key) {
    userGeneratedKey = "";
    key.forEach((element) => userGeneratedKey += element);
  }
}

List<String> alphabetList = [
  "a",
  "b",
  "c",
  "d",
  "e",
  "f",
  "g",
  "h",
  "i",
  "j",
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
];
List<String> keyList = [
  "a",
  "b",
  "c",
  "d",
  "e",
  "f",
  "g",
  "h",
  "i",
  "j",
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
];
