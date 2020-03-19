import 'dart:io';

import 'package:pic_dart_emu/IntelHexParser.dart';
import 'package:test/test.dart';

void main() {
  test('reads lines properly', () async {
    var parser = HexParser(File('./test/test1.hex'));
    
    var lens = [31, 43, 43, 43, 43, 27, 15, 11];
    var i = 0;

    return parser.start((String line) {
      expect(line.length, lens[i++]);
      //print(line.length);
    });
  });
}
