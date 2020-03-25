import 'dart:typed_data';

import 'package:pic_dart_emu/ByteUtilities.dart';
import 'package:pic_dart_emu/HexUtilities.dart';
import 'package:pic_dart_emu/InstructionUtilities.dart';
import 'package:pic_dart_emu/Memory.dart';

enum Instructions {
  unsupported,
  movlw
}

class Instruction {
  final Instructions _name;
  Instructions get name => _name;
  final int _offset;
  final int _mask;
  final Function(ByteData, Memory) run;

  Instruction(this._name, this._offset, this._mask, this.run);

  bool matches(ByteData opcode) {
    return InstructionUtilities.matchesMsbBits(
      opcode, _offset, _mask);
  }
}

class InstructionSet {
  final Iterable<Instruction> _iset = [
    Instruction(Instructions.movlw, 10, 12, (d, m) => print('movlw')) // 11 00xx kkkk kkkk
  ];
  final _unsupportedInstr = Instruction(
    Instructions.unsupported, 0, 0, 
    (d, m) => print('unknown instruction ${HexUtilities.bytesToHex(d)}'));

  Instruction run(ByteData opcode, Memory memory) {
    // first, swap the bytes since its little-endian
    var oc = ByteUtilities.swapBytes(opcode);
    return _iset.singleWhere((p) => p.matches(oc), 
      orElse: () => _unsupportedInstr)
      ..run(oc, memory);
  }
}