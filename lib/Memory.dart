import 'dart:io';
import 'dart:typed_data';

import 'package:pic_dart_emu/Address.dart';

enum MemoryTypes { Program, Data }

class Memory {
  static const DEBUG_LINE_LENGTH = 30;

  static const int PROGRAM_DATA_WORD_SIZE = 1024; //exclusive
  static final int PROGRAM_DATA_BYTE_SIZE = PROGRAM_DATA_WORD_SIZE * WORD_SIZE_BYTES;

  static const int WORD_SIZE_BITS = 14;
  static final int WORD_SIZE_BYTES = (WORD_SIZE_BITS / 8).ceil();

  static const int DATA_BANK_SIZE = 128;

  final _memories = {
    MemoryTypes.Program: ByteData(PROGRAM_DATA_BYTE_SIZE),
    MemoryTypes.Data: ByteData(DATA_BANK_SIZE * 2) // 2 banks of 128. 00-7F, 80-FF
  };

  void setByte(MemoryTypes type, int offset, int value) {
    //print('Setting ${offset} to ${value}');
    _memories[type].setUint8(offset, value);
  }

  int getByte(MemoryTypes type, int offset) {
    return _memories[type].getUint8(offset);
  }

  ByteData getBytes(MemoryTypes type, int offset, int len) {
    return _memories[type].buffer.asByteData(offset, len);
  }

  ByteData getWord(MemoryTypes type, Address addr) {
    return getBytes(type, addr.asInt() * WORD_SIZE_BYTES, WORD_SIZE_BYTES);
  }

  bool isValidAddress(Address a) {
    return a.asInt() < PROGRAM_DATA_WORD_SIZE;
  }

  void debug(MemoryTypes type) {
    for(var i = 0; i < _memories[type].lengthInBytes; ++i) {
      var hexStr = _memories[type].getUint8(i).toRadixString(16);
      if (hexStr.length == 1) stdout.write('0');
      stdout.write(hexStr);
      stdout.write(' ');
      if (i > 0 && i % DEBUG_LINE_LENGTH == 0) stdout.write('\n');
    }
    stdout.write('\n');
  }
}