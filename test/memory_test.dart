import 'package:pic_dart_emu/Memory.dart';
import 'package:test/test.dart';

void main() {
  test('sets a byte correctly', () {
    var mem = Memory();
    mem.setByte(0, 2);
    expect(mem.getByte(0), 2);
  });
}
