import 'dart:typed_data';

import 'package:pic_dart_emu/ByteUtilities.dart';
import 'package:pic_dart_emu/DataMemoryBanks.dart';
import 'package:pic_dart_emu/hexparser/HexUtilities.dart';

// This is used as a WORD address. So when addressing Memory, it's multiplied by 2.
// This holds a 13 bit program counter too.
class Address {
  
  static final SIZE = 2;

  ByteData _addr;
  ByteData get address => _addr;
  set address(ByteData addr) {
    if (addr.lengthInBytes != SIZE) {
      throw ArgumentError('Address must be ${SIZE} bytes');
    }
    _addr = addr;
  }

  Address(this._addr);

  Address.fromInt(int a) {
    _addr = ByteUtilities.int16ToBytes(a);
  }

  int asInt() {
    return _addr.getUint16(0);
  }

  void increment() {
    incrementBy(1);
  }

  void incrementBy(int count) {
    _addr = ByteUtilities.int16ToBytes(asInt() + count);
  }

  // The eleven-bit immediate value is loaded into PC bits <10:0>. The
  // upper bits of PC are loaded from PCLATH<4:3>.
  void goto(int addr, DataMemory data) {
    _addr = ByteUtilities.int16ToBytes(0); // just to make sure bits > 13 are 0s.
    var pclShifted = data.registerPclath << 8;
    var a = ByteUtilities.copyBits(addr, pclShifted, 13, 2);
    
    _addr = ByteUtilities.int16ToBytes(a);
  }

  bool operator <(String hexAddr) {
    return asInt() < HexUtilities.hexToInt(hexAddr);
  }

  bool operator >(String hexAddr) {
    return asInt() > HexUtilities.hexToInt(hexAddr);
  }

  bool operator <=(String hexAddr) {
    return asInt() <= HexUtilities.hexToInt(hexAddr);
  }
}