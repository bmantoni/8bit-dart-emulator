import 'dart:typed_data';

class InstructionUtilities {
  static bool matchesMsbBits(ByteData opcode, int bits, int mask) {
    var x = opcode.getUint16(0) >> bits;
    return x == mask;
  }
}
