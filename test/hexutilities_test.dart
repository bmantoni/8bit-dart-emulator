import 'dart:io';

import 'package:pic_dart_emu/HexUtilities.dart';
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
}
