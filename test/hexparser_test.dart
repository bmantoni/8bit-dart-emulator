import 'dart:io';

import 'package:pic_dart_emu/hexparser/HexLine.dart';
import 'package:pic_dart_emu/IntelHexParser.dart';
import 'package:test/test.dart';

void main() {
  test('reads lines properly', () async {
    var parser = HexParser(File('./test/test1.hex'));
    
    var dataLens = [10, 16, 16, 16, 16, 8, 2, 0];
    var i = 0;

    return parser.start((HexLine line) {
      expect(line.byteCount.intValue, dataLens[i++]);
    });
  });
}
