import 'dart:typed_data';

class HexUtilities {
  static int hexToInt(String str) {
    return int.parse(str, radix: 16);
  }
  static ByteData hexToBytes(String str) {
    return ByteData(str.length ~/ 2)..setInt16(0, hexToInt(str));
  }
}