import 'package:pic_dart_emu/Address.dart';
import 'package:pic_dart_emu/hexparser/HexUtilities.dart';
import 'package:pic_dart_emu/InstructionSet.dart';
import 'package:pic_dart_emu/Memory.dart';

class PIC {
  final Memory _memory = Memory();
  Memory get memory => _memory;

  final InstructionSet _iset = InstructionSet();

  // The PC will increment from 0x0000-0x1FFF and wrap to 0x000, 
  // 0x2000-0x3FFF and wrap around to 0x2000 (not to 0x0000)
  final Address _programCounter = Address.fromInt(0x0000);
  Address get pc => _programCounter;

  void run() {
    while (!stop()) {
      print('Running instruction at ${HexUtilities.bytesToHex(_programCounter.address)}');
      var opcode = _memory.program.getWord(_programCounter);
      var control = _iset.run(opcode, memory);
      nextInstruction(control);
    }
  }
    
  bool stop() {
    // for now, don't wrap around.
    return !_memory.program.isValidAddress(_programCounter);
  }

  void nextInstruction(ControlFlow control) {
    if (control.none) {
      _programCounter.increment();
    } else if (control.isSkip) {
      _programCounter.incrementBy(2);
    } else if (control.isGoto) {
      _programCounter.goto(control.goto, _memory.data);
    }
  }
}