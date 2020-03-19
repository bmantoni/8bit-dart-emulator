import 'dart:io';

import 'package:pic_dart_emu/HexLine.dart';
import 'package:pic_dart_emu/IntelHexParser.dart';
import 'package:pic_dart_emu/Memory.dart';

class ProgramLoader {
  File programFile;

  ProgramLoader(this.programFile);

  Future load(Memory memory) {
    var parser = HexParser(programFile);
    
    return parser.start((HexLine line) {
      // skip the first, and last lines
      if (line.address.eightBitAddressValue == 0 || line.address.eightBitAddressValue > Memory.PROGRAM_DATA_SIZE) return;

      //print('Loading line with byte length: ${line.byteCount.intValue.toString()}');
      for (var i = 0; i < line.byteCount.intValue; ++i) {
        memory.setByte(line.address.eightBitAddressValue + i, line.getDataByte(i));
      }
    });  
  }
}