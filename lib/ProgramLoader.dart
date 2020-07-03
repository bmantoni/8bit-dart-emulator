import 'dart:io';

import 'package:pic_dart_emu/hexparser/HexLine.dart';
import 'package:pic_dart_emu/IntelHexParser.dart';
import 'package:pic_dart_emu/Memory.dart';
import 'package:pic_dart_emu/ProgramMemory.dart';

class ProgramLoader {
  File _programFile;
  String _programString;

  ProgramLoader(this._programFile);
  ProgramLoader.fromProgramString(this._programString);

  void load(Memory memory) async {
    var parser = _programFile != null ? 
      HexParser(_programFile) : HexParser.fromString(_programString);
    
    await parser.start((HexLine line) {
      // skip the first, and last lines
      if (line.address.intValue > 0 && line.address.intValue <= ProgramMemory.PROGRAM_DATA_BYTE_SIZE) {
        loadDataBytes(memory, line);
      }
    });  
  }

  void loadDataBytes(Memory memory, HexLine line) {
      //print('Loading line with byte length: ${line.byteCount.intValue.toString()}');
      // this could be moved to Memory class?
      for (var i = 0; i < line.byteCount.intValue; ++i) {
        memory.program.setByte(line.address.intValue + i, line.getDataByte(i));
      }
  }
}