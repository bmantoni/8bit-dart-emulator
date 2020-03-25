import 'dart:typed_data';

import 'package:pic_dart_emu/ByteUtilities.dart';
import 'package:pic_dart_emu/InstructionUtilities.dart';
import 'package:pic_dart_emu/Memory.dart';

enum Instructions {
  unsupported,
  movlw,
  bsf
}

class Fields {
  int d, f, b, k;
  Fields({this.d, this.f, this.b, this.k});
}

abstract class Instruction {
  Instructions get name;
  final int _offset;
  final int _mask;
  final Function(Fields, Memory) _runFunc;

  Instruction(this._offset, this._mask, this._runFunc);

  void run(ByteData opcode, Memory memory) {
    print('Running ${name}');
    var f = extractFields(opcode);
    _runFunc(f, memory);
  }

  bool matches(ByteData opcode) {
    return InstructionUtilities.matchesMsbBits(opcode, _offset, _mask);
  }

  Fields extractFields(ByteData opcode);

  int extractField(ByteData opcode, int rightBits, length) {
    return InstructionUtilities.extractBits(opcode, rightBits, length)
      .getUint16(0);
  }
}

class MovLwInstruction extends Instruction {
  MovLwInstruction(int offset, int mask, Function(Fields, Memory) runFunc): 
    super(offset, mask, runFunc);

  @override
  Fields extractFields(ByteData opcode) {
    return Fields(k: extractField(opcode, 8, 8));
  }

  @override
  Instructions get name => Instructions.movlw;
}

class UnsupportedInstruction extends Instruction {
  UnsupportedInstruction(int offset, int mask, Function(Fields, Memory) runFunc): 
    super(offset, mask, runFunc);

  @override
  Fields extractFields(ByteData opcode) {
    return null;
  }

  @override
  Instructions get name => Instructions.unsupported;
}

class InstructionSet {
  final Iterable<Instruction> _iset = [
    MovLwInstruction(10, 12, (f, m) => m.w = f.k),    // 11 00xx kkkk kkkk
    //Instruction(Instructions.bsf, 10, 5, (f, m) => print('TODO')) // 01 01bb bfff ffff
  ];
  final _unsupportedInstr = UnsupportedInstruction(0, 0, (f, m) => null);

  Instruction run(ByteData opcode, Memory memory) {
    // first, swap the bytes since its little-endian
    var oc = ByteUtilities.swapBytes(opcode);
    return _iset.singleWhere((p) => p.matches(oc), 
      orElse: () => _unsupportedInstr)
      ..run(oc, memory);
  }
}