import 'dart:typed_data';

import 'package:pic_dart_emu/ByteUtilities.dart';
import 'package:pic_dart_emu/HexUtilities.dart';

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
  Address.fromString(String hex) {
    _addr = HexUtilities.hexToBytes(hex);
  }
  Address.fromInt(int a) {
    _addr = ByteUtilities.int16ToBytes(a);
  }

  int asInt() {
    return _addr.getUint16(0);
  }

  void increment() {
    _addr = ByteUtilities.int16ToBytes(asInt() + 1);
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