import 'dart:typed_data';

import 'package:pic_dart_emu/InstructionUtilities.dart';
import 'package:pic_dart_emu/Memory.dart';

abstract class Instruction {
  void run(ByteData opcode, Memory memory);
  bool matches(ByteData opcode);
}

class MovLw implements Instruction {
  @override
  bool matches(ByteData opcode) {
    return InstructionUtilities.matchesMsbBits(opcode, 10, 12); // 11 00xx kkkk kkkk
  }

  @override
  void run(ByteData opcode, Memory memory) {
    // TODO
  }
}

class InstructionSet {
  var instructions = {
    'movlw': MovLw
  };
}