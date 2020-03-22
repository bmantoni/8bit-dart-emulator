import 'package:pic_dart_emu/Address.dart';
import 'package:pic_dart_emu/Memory.dart';

class PIC {
  Memory memory = Memory();

  // The PC will increment from 0x0000-0x1FFF and wrap to 0x000, 
  // 0x2000-0x3FFF and wrap around to 0x2000 (not to 0x0000)
  final Address _programCounter = Address.fromString('0000');

  void run() {
    while (!stop()) {
      // get instruction at pc addr
      // run it
      //   look it up in a table (matching the bit pattern)
    }
  }
    
  bool stop() {
    // for now, don't wrap around.
    return _programCounter <= '1FFF';
  }
}