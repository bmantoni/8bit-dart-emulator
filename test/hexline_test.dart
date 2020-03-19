import 'dart:io';

import 'package:pic_dart_emu/HexLine.dart';
import 'package:test/test.dart';

void main() {
  test('can set byteCount', () {
    final lineStr = ':0A0000008316FF2390008312FD2BEE';
    var line = HexLine(lineStr);
    expect(line.byteCount.value, '0A');
  });
}
