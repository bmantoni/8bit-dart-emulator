import 'dart:io';
import 'dart:typed_data';

import 'package:pic_dart_emu/hexparser/HexUtilities.dart';
import 'package:test/test.dart';

void main() {
  test('parses hex to bytes 1', () {
    var str = '0400';

    expect(HexUtilities.hexToBytes(str).getUint8(0), 4);
  });

  test('parses hex to int 1', () {
    var str = '0400';

    expect(HexUtilities.hexToInt(str), 1024);
  });

  test('bytes to hex', () {
    var b = ByteData(2);
    b.setUint16(0, 223);

    expect(HexUtilities.bytesToHex(b), '0DF'); // for now not worrying about the formatting here
  });
}
