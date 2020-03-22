import 'dart:io';

import 'package:pic_dart_emu/HexUtilities.dart';
import 'package:pic_dart_emu/InstructionSet.dart';
import 'package:test/test.dart';

void main() {
  test('match msb', () {
    var str = '30DF'; // assume bytes reversed by now.

    expect(MovLw().matches(HexUtilities.hexToBytes(str)), true);
  });

  test('match msb, less significant bytes dont matter', () {
    var str = '30FF';

    expect(MovLw().matches(HexUtilities.hexToBytes(str)), true);
  });

  test('dont match msb when wrong', () {
    var str = 'E0FF';

    expect(MovLw().matches(HexUtilities.hexToBytes(str)), false);
  });
}
