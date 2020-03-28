import 'package:pic_dart_emu/ByteUtilities.dart';
import 'package:pic_dart_emu/DataMemoryBanks.dart';
import 'package:test/test.dart';

void main() {
  test('setting a byte', () {
    var mem = DataMemory();
    mem.setByte(DataMemory.STATUS_ADDR, 0x5);
    var x = mem.getBytes(DataMemory.STATUS_ADDR, 1);
    expect(x.getUint8(0), 0x5);
  });

  test('mapped bytes set in both banks', () {
    var mem = DataMemory();
    // set value in bank 0
    mem.setByte(0x2, 0x5);
    mem.setByte(DataMemory.STATUS_ADDR, 
      ByteUtilities.setBit(mem.getByte(DataMemory.STATUS_ADDR), 5));

    // that value should be the same in bank 1
    expect(mem.getByte(0x2), 0x5);
  });

  test('unmapped bytes different in banks', () {
    var mem = DataMemory();
    // set value in bank 0
    mem.setByte(0x20, 0x5);
    mem.setByte(DataMemory.STATUS_ADDR, 
      ByteUtilities.setBit(mem.getByte(DataMemory.STATUS_ADDR), 5));

    // that value should be 0 in bank 1
    expect(mem.getByte(0x20), 0x0);
  });
}
