import 'dart:typed_data';

import 'package:pic_dart_emu/ByteUtilities.dart';
import 'package:pic_dart_emu/InstructionLib.dart';
import 'package:pic_dart_emu/Memory.dart';

class Fields {
  int d, f, b, k;
  Fields({this.d, this.f, this.b, this.k});
}

abstract class Instruction {
  Instructions get name;
  // the right offset to the first lsb of the fixed operand code
  int get offset;
  int get mask;
  Function(Fields, Memory) get runFunc;

  void run(ByteData opcode, Memory memory) {
    print('Running ${name}');
    var f = extractFields(opcode);
    runFunc(f, memory);
  }

  bool matches(ByteData opcode) {
    return ByteUtilities.matchesMsbBits(opcode, offset, mask);
  }

  Fields extractFields(ByteData opcode);

  int extractField(ByteData opcode, int rightBits, length) {
    return ByteUtilities.extractBits(opcode, rightBits, length)
      .getUint16(0);
  }
}

class InstructionSet {
  final Iterable<Instruction> _iset = [
    MovLwInstruction(),    // 11 00xx kkkk kkkk
    BsfInstruction(),      // 01 01bb bfff ffff
    MovWfInstruction(),    // 00 0000 1fff ffff
  ];
  final _unsupportedInstr = UnsupportedInstruction();

  Instruction run(ByteData opcode, Memory memory) {
    // first, swap the bytes since its little-endian
    var oc = ByteUtilities.swapBytes(opcode);
    return _iset.singleWhere((p) => p.matches(oc), 
      orElse: () => _unsupportedInstr)
      ..run(oc, memory);
  }
}