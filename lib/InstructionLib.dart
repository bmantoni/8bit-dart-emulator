import 'dart:typed_data';

import 'package:pic_dart_emu/InstructionSet.dart';
import 'package:pic_dart_emu/Memory.dart';

enum Instructions {
  unsupported,
  movlw,
  movwf,
  bsf
}

class MovLwInstruction extends Instruction {
  @override
  Fields extractFields(ByteData opcode) {
    return Fields(k: extractField(opcode, 8, 8));
  }

  @override
  Instructions get name => Instructions.movlw;

  @override
  int get mask => 12;

  @override
  int get offset => 10;

  @override
  Function(Fields, Memory) get runFunc => (f, m) => m.w = f.k;
}

class BsfInstruction extends Instruction {
  @override
  Fields extractFields(ByteData opcode) {
    return Fields(b: extractField(opcode, 10, 3), f: extractField(opcode, 7, 7));
  }

  @override
  Instructions get name => Instructions.bsf;

  @override
  int get mask => 5;

  @override
  int get offset => 10;

  @override
  Function(Fields, Memory) get runFunc => (f, m) => /* select bank 1? */ null;
}

// move W to f
class MovWfInstruction extends Instruction {
  @override
  Fields extractFields(ByteData opcode) {
    return Fields(f: extractField(opcode, 7, 7));
  }

  @override
  int get mask => 1;

  @override
  int get offset => 7;

  @override
  Instructions get name => Instructions.movwf;

  @override
  Function(Fields, Memory) get runFunc => (f, m) => m.setByte(MemoryTypes.Data, f.f, m.w);
}

class UnsupportedInstruction extends Instruction {
  @override
  Fields extractFields(ByteData opcode) {
    return null;
  }

  @override
  Instructions get name => Instructions.unsupported;

  @override
  int get mask => 0;

  @override
  int get offset => 0;

  @override
  Function(Fields, Memory) get runFunc => (f, m) => null;
}