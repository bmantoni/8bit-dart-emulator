import 'package:pic_dart_emu/hexparser/HexUtilities.dart';
import 'package:pic_dart_emu/Memory.dart';
import 'package:test/test.dart';

void main() {
  test('sets and gets a byte correctly', () {
    var mem = Memory();
    mem.program.setByte(0, 2);
    expect(mem.program.getByte(0), 2);
  });

  test('gets 2 bytes correctly', () {
    var mem = Memory();
    mem.program.setByte(0, 2);
    mem.program.setByte(1, 255);
    expect(HexUtilities.bytesToHex(mem.program.getBytes(0, 2)), '2FF');
    expect(mem.program.getBytes(0, 2).getInt16(0), 767);
  });
}
