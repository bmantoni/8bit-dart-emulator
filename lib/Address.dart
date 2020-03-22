import 'dart:typed_data';

import 'package:pic_dart_emu/HexUtilities.dart';

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

  int asInt() {
    return _addr.getInt16(0);
  }

  bool operator <(String hexAddr) {
    return asInt() < HexUtilities.hexToInt(hexAddr);
  }

  bool operator <=(String hexAddr) {
    return asInt() <= HexUtilities.hexToInt(hexAddr);
  }

  bool operator >(String hexAddr) {
    return asInt() > HexUtilities.hexToInt(hexAddr);
  }
}