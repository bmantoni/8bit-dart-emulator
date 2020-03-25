import 'dart:typed_data';

import 'package:pic_dart_emu/ByteUtilities.dart';

class InstructionUtilities {
  static bool matchesMsbBits(ByteData opcode, int bits, int mask) {
    var x = opcode.getUint16(0) >> bits;
    return x == mask;
  }
  static ByteData extractBits(ByteData data, int bitsFromEnd, int length) {
    // this '2' shouldn't be here. the word byte size is set elsewhere
    if(data.lengthInBytes != 2) throw ArgumentError('Must be 2 bytes');
    
    // clear the left bits
    var dataLenBits = data.lengthInBytes * 8;
    var leftBits = dataLenBits - bitsFromEnd;
    var x = data.getUint16(0) << leftBits;
    // this got quite ugly, but if I just shift left then right, the old value persists.
    var y = ByteUtilities.int16ToBytes(x);
    // clear the right bits
    x = y.getUint16(0) >> (dataLenBits - length);
    return ByteUtilities.int16ToBytes(x);
  }
}
