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
      if (line.address.intValue > 0 && line.address.intValue <= Memory.PROGRAM_DATA_BYTE_SIZE) {
        loadDataBytes(memory, line);
      }
    });  
  }

  void loadDataBytes(Memory memory, HexLine line) {
      //print('Loading line with byte length: ${line.byteCount.intValue.toString()}');
      // this could be moved to Memory class?
      for (var i = 0; i < line.byteCount.intValue; ++i) {
        memory.setByte(MemoryTypes.Program, line.address.intValue + i, line.getDataByte(i));
      }
  }
}