import 'package:pic_dart_emu/Memory.dart';
import 'package:test/test.dart';

void main() {
  test('sets a byte correctly', () {
    var mem = Memory();
    mem.setByte(MemoryTypes.Program, 0, 2);
    expect(mem.getByte(MemoryTypes.Program, 0), 2);
  });
}
