import 'dart:typed_data';

import 'package:pic_dart_emu/DataMemoryBanks.dart';
import 'package:pic_dart_emu/ProgramMemory.dart';

enum MemoryTypes { Program, Data }
enum Registers { W, Status }

class Memory {
  static const DEBUG_LINE_LENGTH = 30;

  static const int REGISTER_BYTE_SIZE = 1;

  final _programMemory = ProgramMemory();
  ProgramMemory get program => _programMemory;
  final _dataMemory = DataMemory();
  DataMemory get data => _dataMemory;

  final _registers = {
      Registers.W: ByteData(REGISTER_BYTE_SIZE),                // accumulator
  };

  int get w => _registers[Registers.W].getUint8(0);
  set w(int d) {
    if(d > 255) {
      throw ArgumentError('value must be less than ${REGISTER_BYTE_SIZE} bytes');
    }
    _registers[Registers.W].setUint8(0, d);
  }

/*
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
  */
}