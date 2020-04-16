import 'dart:typed_data';

import 'package:pic_dart_emu/Address.dart';
import 'package:pic_dart_emu/ByteUtilities.dart';
import 'package:pic_dart_emu/InstructionLib.dart';
import 'package:pic_dart_emu/Memory.dart';

class Fields {
  int d, f, b, k;
  Fields({this.d, this.f, this.b, this.k});
}

class ControlFlow {
  int goto;
  bool get isGoto => goto != null;
  Address call; // TODO is this actually an address?
  bool skip;    // skip/noop the next instruction
  bool get isSkip => skip != null && skip;

  // TODO returns
  
  bool none = false;

  ControlFlow({this.goto, this.call, this.skip});
  ControlFlow.none() { none = true; }
}

abstract class Instruction {
  Instructions get name;
  // the right offset to the first lsb of the fixed operand code
  int get offset;
  int get mask;
  dynamic Function(Fields, Memory) get runFunc => null;
  // this is optional. only needed if the instr affects control flow
  ControlFlow Function(Fields, Memory) get controlFunc => null;

  ControlFlow run(ByteData opcode, Memory memory) {
    print('Running ${name}');
    var f = extractFields(opcode);
    if (runFunc != null) runFunc(f, memory);
    return controlFunc != null ? controlFunc(f, memory) : ControlFlow.none();
  }

  bool matches(ByteData opcode) {
    return ByteUtilities.matchesMsbBits(opcode, offset, mask);
  }

  Fields extractFields(ByteData opcode);

  int extractField(ByteData opcode, int rightBits, length) {
    return ByteUtilities.extractBits(opcode, rightBits, length);
  }
}

class InstructionSet {
  final Iterable<Instruction> _iset = [
    MovLw(),    // 11 00xx kkkk kkkk
    Bsf(),      // 01 01bb bfff ffff
    Bcf(),      // 01 00bb bfff ffff
    MovWf(),    // 00 0000 1fff ffff
    DecFsz(),   // 00 1011 dfff ffff
    Goto(),     // 10 1kkk kkkk kkkk
    AddWf(),    // 00 0111 dfff ffff
    IncF()      // 00 1010 dfff ffff
  ];
  final _unsupportedInstr = Unsupported();

  ControlFlow run(ByteData opcode, Memory memory) {
    // first, swap the bytes since its little-endian
    var oc = ByteUtilities.swapBytes(opcode);
    return getMatchingInstr(oc).run(oc, memory);
  }

  Instruction getMatchingInstr(ByteData oc) {
    return _iset.singleWhere((p) => p.matches(oc), 
      orElse: () => _unsupportedInstr);
  }
}