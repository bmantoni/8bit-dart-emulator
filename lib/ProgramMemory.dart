import 'dart:typed_data';

import 'package:pic_dart_emu/Address.dart';
import 'package:pic_dart_emu/ByteStore.dart';

class ProgramMemory extends ByteStore {
  
  static const int PROGRAM_DATA_WORD_SIZE = 1024; //exclusive
  static final int PROGRAM_DATA_BYTE_SIZE = PROGRAM_DATA_WORD_SIZE * WORD_SIZE_BYTES;

  static const int WORD_SIZE_BITS = 14;
  static final int WORD_SIZE_BYTES = (WORD_SIZE_BITS / 8).ceil(); //2

  final _mem = ByteData(PROGRAM_DATA_BYTE_SIZE);

  ByteData getWord(Address addr) {
    return getBytes(addr.asInt() * WORD_SIZE_BYTES, WORD_SIZE_BYTES);
  }
  
  bool isValidAddress(Address a) {
    return a.asInt() < PROGRAM_DATA_WORD_SIZE;
  }

  @override
  int getByte(int offset) {
    return _mem.getUint8(offset);
  }

  @override
  ByteData getBytes(int offset, int len) {
    return _mem.buffer.asByteData(offset, len);
  }

  @override
  void setByte(int offset, int value) {
    _mem.setUint8(offset, value);
  }

  @override
  void updateByte(int offset, int Function(int) f) {
    setByte(offset, f(getByte(offset)));
  }

  int get lengthInWords => PROGRAM_DATA_WORD_SIZE;
}
