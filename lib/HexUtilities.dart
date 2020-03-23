import 'dart:typed_data';

class HexUtilities {
  static int hexToInt(String str) {
    return int.parse(str, radix: 16);
  }
  
  static String bytesToHex(ByteData d) {
    var buffer = StringBuffer();
    for(var i = 0; i < d.lengthInBytes; ++i) {
      buffer.write(d.getUint8(i).toRadixString(16));
    }
    return buffer.toString().toUpperCase();
  }

  static ByteData hexToBytes(String str) {
    var bytes = ByteData(str.length ~/ 2);
    for (var i = 0; i < bytes.lengthInBytes; ++i) {
      bytes.setUint8(i, hexToInt(str.substring(i * 2, i * 2 + 2)));
    }
    return bytes;
  }
}