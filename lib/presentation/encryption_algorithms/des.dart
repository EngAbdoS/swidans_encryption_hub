import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:convert/convert.dart';

import 'package:dart_des/dart_des.dart';

class DESAlgorithm {


  bool keyValidation(String userKey)
  {
    return userKey.length==8;

  }



  String encode(String message, String userKey) {
    List<int> encrypted;
    DES desECB = DES(key: userKey.codeUnits, mode: DESMode.ECB);
    encrypted = desECB.encrypt(message.codeUnits);

    return base64.encode(encrypted);
  }

  String decode(String message, String userKey) {
    List<int> decrypted;
    DES desECB = DES(key: userKey.codeUnits, mode: DESMode.ECB);
    List<int> encrypted = base64.decode(message);
    decrypted = desECB.decrypt(encrypted);

    return utf8.decode(decrypted);
  }
  List<int> iv = [1, 2, 3, 4, 5, 6, 7, 8];

//
//   static const List<int> PC1Table = [
//     57,
//     49,
//     41,
//     33,
//     25,
//     17,
//     9,
//     1,
//     58,
//     50,
//     42,
//     34,
//     26,
//     18,
//     10,
//     2,
//     59,
//     51,
//     43,
//     35,
//     27,
//     19,
//     11,
//     3,
//     60,
//     52,
//     44,
//     36,
//     63,
//     55,
//     47,
//     39,
//     31,
//     23,
//     15,
//     7,
//     62,
//     54,
//     46,
//     38,
//     30,
//     22,
//     14,
//     6,
//     61,
//     53,
//     45,
//     37,
//     29,
//     21,
//     13,
//     5,
//     28,
//     20,
//     12,
//     4
//   ];
//
//   static const List<int> PC2Table = [
//     14,
//     17,
//     11,
//     24,
//     1,
//     5,
//     3,
//     28,
//     15,
//     6,
//     21,
//     10,
//     23,
//     19,
//     12,
//     4,
//     26,
//     8,
//     16,
//     7,
//     27,
//     20,
//     13,
//     2,
//     41,
//     52,
//     31,
//     37,
//     47,
//     55,
//     30,
//     40,
//     51,
//     45,
//     33,
//     48,
//     44,
//     49,
//     39,
//     56,
//     34,
//     53,
//     46,
//     42,
//     50,
//     36,
//     29,
//     32
//   ];
//
//   static const List<int> IPTable = [
//     58,
//     50,
//     42,
//     34,
//     26,
//     18,
//     10,
//     2,
//     60,
//     52,
//     44,
//     36,
//     28,
//     20,
//     12,
//     4,
//     62,
//     54,
//     46,
//     38,
//     30,
//     22,
//     14,
//     6,
//     64,
//     56,
//     48,
//     40,
//     32,
//     24,
//     16,
//     8,
//     57,
//     49,
//     41,
//     33,
//     25,
//     17,
//     9,
//     1,
//     59,
//     51,
//     43,
//     35,
//     27,
//     19,
//     11,
//     3,
//     61,
//     53,
//     45,
//     37,
//     29,
//     21,
//     13,
//     5,
//     63,
//     55,
//     47,
//     39,
//     31,
//     23,
//     15,
//     7
//   ];
//
//   static const List<int> FPTable = [
//     40,
//     8,
//     48,
//     16,
//     56,
//     24,
//     64,
//     32,
//     39,
//     7,
//     47,
//     15,
//     55,
//     23,
//     63,
//     31,
//     38,
//     6,
//     46,
//     14,
//     54,
//     22,
//     62,
//     30,
//     37,
//     5,
//     45,
//     13,
//     53,
//     21,
//     61,
//     29,
//     36,
//     4,
//     44,
//     12,
//     52,
//     20,
//     60,
//     28,
//     35,
//     3,
//     43,
//     11,
//     51,
//     19,
//     59,
//     27,
//     34,
//     2,
//     42,
//     10,
//     50,
//     18,
//     58,
//     26,
//     33,
//     1,
//     41,
//     9,
//     49,
//     17,
//     57,
//     25
//   ];
//
//   static const List<int> EBitSelectionTable = [
//     32,
//     1,
//     2,
//     3,
//     4,
//     5,
//     4,
//     5,
//     6,
//     7,
//     8,
//     9,
//     8,
//     9,
//     10,
//     11,
//     12,
//     13,
//     12,
//     13,
//     14,
//     15,
//     16,
//     17,
//     16,
//     17,
//     18,
//     19,
//     20,
//     21,
//     20,
//     21,
//     22,
//     23,
//     24,
//     25,
//     24,
//     25,
//     26,
//     27,
//     28,
//     29,
//     28,
//     29,
//     30,
//     31,
//     32,
//     1
//   ];
//
//   static const List<int> SBox = [
//     // S1
//     14,
//     4,
//     13,
//     1,
//     2,
//     15,
//     11,
//     8,
//     3,
//     10,
//     6,
//     12,
//     5,
//     9,
//     0,
//     7,
//     0,
//     15,
//     7,
//     4,
//     14,
//     2,
//     13,
//     1,
//     10,
//     6,
//     12,
//     11,
//     9,
//     5,
//     3,
//     8,
//     4,
//     1,
//     14,
//     8,
//     13,
//     6,
//     2,
//     11,
//     15,
//     12,
//     9,
//     7,
//     3,
//     10,
//     5,
//     0,
//     15,
//     12,
//     8,
//     2,
//     4,
//     9,
//     1,
//     7,
//     5,
//     11,
//     3,
//     14,
//     10,
//     0,
//     6,
//     13,
//     // S2
//     15,
//     1,
//     8,
//     14,
//     6,
//     11,
//     3,
//     4,
//     9,
//     7,
//     2,
//     13,
//     12,
//     0,
//     5,
//     10,
//     3,
//     13,
//     4,
//     7,
//     15,
//     2,
//     8,
//     14,
//     12,
//     0,
//     1,
//     10,
//     6,
//     9,
//     11,
//     5,
//     0,
//     14,
//     7,
//     11,
//     10,
//     4,
//     13,
//     1,
//     5,
//     8,
//     12,
//     6,
//     9,
//     3,
//     2,
//     15,
//     13,
//     8,
//     10,
//     1,
//     3,
//     15,
//     4,
//     2,
//     11,
//     6,
//     7,
//     12,
//     0,
//     5,
//     14,
//     9,
//     // S3
//     10,
//     0,
//     9,
//     14,
//     6,
//     3,
//     15,
//     5,
//     1,
//     13,
//     12,
//     7,
//     11,
//     4,
//     2,
//     8,
//     13,
//     7,
//     0,
//     9,
//     3,
//     4,
//     6,
//     10,
//     2,
//     8,
//     5,
//     14,
//     12,
//     11,
//     15,
//     1,
//     13,
//     6,
//     4,
//     9,
//     8,
//     15,
//     3,
//     0,
//     11,
//     1,
//     2,
//     12,
//     5,
//     10,
//     14,
//     7,
//     1,
//     10,
//     13,
//     0,
//     6,
//     9,
//     8,
//     7,
//     4,
//     15,
//     14,
//     3,
//     11,
//     5,
//     2,
//     12,
//     // S4
//     7,
//     13,
//     14,
//     3,
//     0,
//     6,
//     9,
//     10,
//     1,
//     2,
//     8,
//     5,
//     11,
//     12,
//     4,
//     15,
//     13,
//     8,
//     11,
//     5,
//     6,
//     15,
//     0,
//     3,
//     4,
//     7,
//     2,
//     12,
//     1,
//     10,
//     14,
//     9,
//     10,
//     6,
//     9,
//     0,
//     12,
//     11,
//     7,
//     13,
//     15,
//     1,
//     3,
//     14,
//     5,
//     2,
//     8,
//     4,
//     3,
//     15,
//     0,
//     6,
//     10,
//     1,
//     13,
//     8,
//     9,
//     4,
//     5,
//     11,
//     12,
//     7,
//     2,
//     14,
//     // S5
//     2,
//     12,
//     4,
//     1,
//     7,
//     10,
//     11,
//     6,
//     8,
//     5,
//     3,
//     15,
//     13,
//     0,
//     14,
//     9,
//     14,
//     11,
//     2,
//     12,
//     4,
//     7,
//     13,
//     1,
//     5,
//     0,
//     15,
//     10,
//     3,
//     9,
//     8,
//     6,
//     4,
//     2,
//     1,
//     11,
//     10,
//     13,
//     7,
//     8,
//     15,
//     9,
//     12,
//     5,
//     6,
//     3,
//     0,
//     14,
//     11,
//     8,
//     12,
//     7,
//     1,
//     14,
//     2,
//     13,
//     6,
//     15,
//     0,
//     9,
//     10,
//     4,
//     5,
//     3,
//     // S6
//     12,
//     1,
//     10,
//     15,
//     9,
//     2,
//     6,
//     8,
//     0,
//     13,
//     3,
//     4,
//     14,
//     7,
//     5,
//     11,
//     10,
//     15,
//     4,
//     2,
//     7,
//     12,
//     9,
//     5,
//     6,
//     1,
//     13,
//     14,
//     0,
//     11,
//     3,
//     8,
//     9,
//     14,
//     1,
//     5,
//     0,
//     12,
//     15,
//     7,
//     4,
//     13,
//     6,
//     2,
//     10,
// // S7
//     4,
//     11,
//     2,
//     14,
//     15,
//     0,
//     8,
//     13,
//     3,
//     12,
//     9,
//     7,
//     5,
//     10,
//     6,
//     1,
//     13,
//     0,
//     11,
//     7,
//     4,
//     9,
//     1,
//     10,
//     14,
//     3,
//     5,
//     12,
//     2,
//     15,
//     8,
//     6,
//     1,
//     4,
//     11,
//     13,
//     12,
//     3,
//     7,
//     14,
//     10,
//     15,
//     6,
//     8,
//     0,
//     5,
//     9,
//     2,
//     6,
//     11,
//     13,
//     8,
//     1,
//     4,
//     10,
//     7,
//     9,
//     5,
//     0,
//     15,
//     14,
//     2,
//     3,
//     12,
// // S8
//     13,
//     2,
//     8,
//     4,
//     6,
//     15,
//     11,
//     1,
//     10,
//     9,
//     3,
//     14,
//     5,
//     0,
//     12,
//     7,
//     1,
//     15,
//     13,
//     8,
//     10,
//     3,
//     7,
//     4,
//     12,
//     5,
//     6,
//     11,
//     0,
//     14,
//     9,
//     2,
//     7,
//     11,
//     4,
//     1,
//     9,
//     12,
//     14,
//     2,
//     0,
//     6,
//     10,
//     13,
//     15,
//     3,
//     5,
//     8,
//     2,
//     1,
//     14,
//     7,
//     4,
//     10,
//     8,
//     13,
//     15,
//     12,
//     9,
//     0,
//     3,
//     5,
//     6,
//     11,
//   ];
//
//   static const List<int> PBox = [
//     16,
//     7,
//     20,
//     21,
//     29,
//     12,
//     28,
//     17,
//     1,
//     15,
//     23,
//     26,
//     5,
//     18,
//     31,
//     10,
//     2,
//     8,
//     24,
//     14,
//     32,
//     27,
//     3,
//     9,
//     19,
//     13,
//     30,
//     6,
//     22,
//     11,
//     4,
//     25
//   ];
//
//   static const List<int> LeftShiftSchedule = [
//     1,
//     1,
//     2,
//     2,
//     2,
//     2,
//     2,
//     2,
//     1,
//     2,
//     2,
//     2,
//     2,
//     2,
//     2,
//     1
//   ];
//
//   static const int keyLength = 8;
//
//   ///8; // 56 bits
//
//   static List<int> padPlaintext(List<int> plaintext) {
//     int paddingLength = 8 - (plaintext.length % 8);
//     List<int> padding = List.filled(paddingLength, paddingLength);
//     return Uint8List.fromList([...plaintext, ...padding]);
//   }
//
//   static List<List<int>> splitIntoBlocks(List<int> data) {
//     List<List<int>> blocks = [];
//     for (int i = 0; i < data.length; i += 64) {
//       blocks.add(data.sublist(i, i + 64));
//     }
//     return blocks;
//   }
//
//   static List<int> permute(List<int> input, List<int> permutationTable) {
//     //ok
//     List<int> output = [];
//     print("enterd");
//     for (int i = 0; i < permutationTable.length; i++) {
//       output.add(input[permutationTable[i] - 1]);
//     }
//     print("out");
//     return output;
//   }
//
//   static List<List<int>> generateSubKeys(List<int> key) {
//     //ok
//     List<int> pc1Result = permute(key, PC1Table);
//     print(pc1Result);
//     print(pc1Result.length);
//     //ok
//     List<int> leftHalf = pc1Result.sublist(0, 28);
//     List<int> rightHalf = pc1Result.sublist(28);
//     List<List<int>> subKeys = [];
//     for (int i = 0; i < LeftShiftSchedule.length; i++) {
//       leftHalf = shiftLeft(leftHalf, LeftShiftSchedule[i]);
//       rightHalf = shiftLeft(rightHalf, LeftShiftSchedule[i]);
//       List<int> combinedHalfs = leftHalf + rightHalf;
//       print("go permute");
//       List<int> subKey = permute(combinedHalfs, PC2Table);
//       print("gone");
//       subKeys.add(subKey);
//     }
//     print(subKeys);
//     print(subKeys.length);
//
//     return subKeys;
//   }
//
//   static List<int> shiftLeft(List<int> bits, int shift) {
//     //ok
//     int offset = shift % bits.length;
//     return [...bits.sublist(offset), ...bits.sublist(0, offset)];
//   }
//
//   static List<int> encryptBlock(List<int> block, List<List<int>> subKeys) {
//     List<int> plaintextBits = permute(block, IPTable);
//     print(plaintextBits);
//     List<int> leftHalf = plaintextBits.sublist(0, 32);
//     List<int> rightHalf = plaintextBits.sublist(32);
//     //ok
//     for (int i = 0; i < subKeys.length; i++) {
//       List<int> roundResult = runFeistelRound(leftHalf, rightHalf, subKeys[i]);
//       leftHalf = rightHalf;
//       rightHalf = roundResult;
//     }
//
//     List<int> combinedBlock = rightHalf + leftHalf;
//     print(combinedBlock);
//     List<int> ciphertextBytes = permute(combinedBlock, FPTable);
//     print(ciphertextBytes);
//     return ciphertextBytes;
//   }
//
//   static List<int> runFeistelRound(
//       List<int> leftHalf, List<int> rightHalf, List<int> roundKey) {
//     List<int> expandedRightHalf = permute(rightHalf, EBitSelectionTable);
//     //ok
//     List<int> xoredWithKey = xor(expandedRightHalf, roundKey);
//     print("er");
//     print(xoredWithKey);
//     List<List<int>> sBoxInputs = splitIntoBlocks(xoredWithKey);
//     print("splet");
//     print(sBoxInputs);
//     List<int> sBoxOutputs = [];
//     for (int i = 0; i < sBoxInputs.length; i++) {
//       List<int> input = sBoxInputs[i];
//       int row = (input[0] << 1) + input[5];
//       int column =
//           (input[1] << 3) + (input[2] << 2) + (input[3] << 1) + input[4];
//       int sBoxValue = SBox[(i * 16) + (row * 4) + column];
//       List<int> sBoxOutputBits = [];
//       for (int j = 0; j < 4; j++) {
//         sBoxOutputBits.add((sBoxValue >> (3 - j)) & 1);
//       }
//       sBoxOutputs.addAll(sBoxOutputBits);
//     }
//
//     List<int> permutedSBoxOutputs = permute(sBoxOutputs, PBox);
//     List<int> xoredWithLeftHalf = xor(leftHalf, permutedSBoxOutputs);
//     return xoredWithLeftHalf;
//   }
//
//   static List<int> xor(List<int> a, List<int> b) {
//     List<int> result = [];
//     for (int i = 0; i < a.length; i++) {
//       result.add(a[i] ^ b[i]);
//     }
//     return result;
//   }
//
//   static String encrypt(String plaintext, String key) {
//     Iterable<String> keyBytes = key.codeUnits
//         .map((int strInt) => strInt.toRadixString(2).padLeft(8, '0'));
//     List<int> keyBits = [];
//     keyBytes.forEach((element) {
//       element.split("").forEach((ch) {
//         keyBits.add(int.parse(ch));
//       });
//     });
// // utf8.encode(key).sublist(0, keyLength);//should be bits
//     print(keyBytes);
//     print(keyBits);
//     //ok
//     List<List<int>> subKeys = generateSubKeys(keyBits);
//     //ok
//     Iterable<String> messageBytes = plaintext.codeUnits
//         .map((int strInt) => strInt.toRadixString(2).padLeft(8, '0'));
//     List<int> plaintextBits = [];
//     messageBytes.forEach((element) {
//       element.split("").forEach((ch) {
//         plaintextBits.add(int.parse(ch));
//       });
//     });
//     print("plain pits");
//     print(plaintextBits);
//
//     //List<int> plaintextBytes = padPlaintext(utf8.encode(plaintext));
// // print("plan byts");   print(plaintextBytes);
//
//     List<List<int>> plaintextBlocks = splitIntoBlocks(plaintextBits);
//     //List<List<int>> plaintextBlocksBits=plaintextBlocks.forEach((element) {element.forEach((element) {  })})
//     print("ploc");
//     print(plaintextBlocks);
//
//     List<int> ciphertextBits = [];
//     for (int i = 0; i < plaintextBlocks.length; i++) {
//       List<int> ciphertextBlock = encryptBlock(plaintextBlocks[i], subKeys);
//       ciphertextBits.addAll(ciphertextBlock);
//       print(ciphertextBits);
//     }
//     print("out of blocks");
//     return base64.encode(ciphertextBits);
//   }
}
