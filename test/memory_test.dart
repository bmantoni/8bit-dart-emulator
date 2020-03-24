import 'package:pic_dart_emu/HexUtilities.dart';
import 'package:pic_dart_emu/Memory.dart';
import 'package:test/test.dart';

void main() {
  test('sets and gets a byte correctly', () {
    var mem = Memory();
    mem.setByte(MemoryTypes.Program, 0, 2);
    expect(mem.getByte(MemoryTypes.Program, 0), 2);
  });

  test('gets 2 bytes correctly', () {
    var mem = Memory();
    mem.setByte(MemoryTypes.Program, 0, 2);
    mem.setByte(MemoryTypes.Program, 1, 255);
    expect(HexUtilities.bytesToHex(mem.getBytes(MemoryTypes.Program, 0, 2)), '2FF');
    expect(mem.getBytes(MemoryTypes.Program, 0, 2).getInt16(0), 767);
  });
}
