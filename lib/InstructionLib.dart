import 'dart:typed_data';

import 'package:pic_dart_emu/Address.dart';
import 'package:pic_dart_emu/ByteUtilities.dart';
import 'package:pic_dart_emu/InstructionSet.dart';
import 'package:pic_dart_emu/Memory.dart';

enum Instructions {
  unsupported,
  movlw,
  movwf,
  bsf,
  bcf,
  decfsz,
  goto
}

class MovLw extends Instruction {
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

class Bsf extends Instruction {
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
  Function(Fields, Memory) get runFunc => (f, m) => 
    m.data.setByte(f.f, 
      ByteUtilities.setBit(
        m.data.getByte(f.f), f.b));
}

class Bcf extends Instruction {
  @override
  Fields extractFields(ByteData opcode) {
    return Fields(b: extractField(opcode, 10, 3), f: extractField(opcode, 7, 7));
  }

  @override
  Instructions get name => Instructions.bcf;

  @override
  int get mask => 4;

  @override
  int get offset => 10;

  @override
  Function(Fields, Memory) get runFunc => (f, m) => 
    m.data.setByte(f.f, 
      ByteUtilities.clearBit(
        m.data.getByte(f.f), f.b));
}

// move W to f
class MovWf extends Instruction {
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
  Function(Fields, Memory) get runFunc => (f, m) => m.data.setByte(f.f, m.w);
}

class DecFsz extends Instruction {
  @override
  Fields extractFields(ByteData opcode) {
    return Fields(f: extractField(opcode, 7, 7), d: extractField(opcode, 8, 1));
  }

  @override
  int get mask => 11;

  @override
  int get offset => 8;

  @override
  Instructions get name => Instructions.decfsz;

  int _result;

  //The contents of register ‘f’ are decremented. If ‘d’ is 0, the result
  // is placed in the W register. If ‘d’ is 1, the result is placed 
  // back in register ‘f’. If the result is 1, the next instruction is executed. 
  // If the result is 0, then a NOP is executed instead, making it a 2TCY instruction.
  @override
  Function(Fields, Memory) get runFunc => (f, m) { 
    _result = m.data.getByte(f.f) == 0 ? 0 : m.data.getByte(f.f) - 1; // should i prevent the rollover?
    print(_result);
    if (f.d == 0) {
      m.w = _result;
    } else if (f.d == 1) {
      m.data.setByte(f.f, _result);
    }
  };

  @override
  ControlFlow Function(Fields, Memory) get controlFunc => 
    (f, m) => _result == 0 ? ControlFlow(skip: true) : ControlFlow.none();
}

class Goto extends Instruction {
  @override
  Fields extractFields(ByteData opcode) {
    return Fields(k: extractField(opcode, 11, 11));
  }

  @override
  int get mask => 5;

  @override
  int get offset => 11;

  @override
  Instructions get name => Instructions.goto;

  @override
  Function(Fields, Memory) get runFunc => (f, m) => {};

  @override
  ControlFlow Function(Fields, Memory) get controlFunc => 
    (f, m) => ControlFlow(goto: f.k);
}

class Unsupported extends Instruction {
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