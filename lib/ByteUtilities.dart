import 'dart:typed_data';

class ByteUtilities {
  static ByteData swapBytes(ByteData input) {
    var output = ByteData(input.lengthInBytes);
    for(var i = 0; i < input.lengthInBytes ~/ 2; ++i) {
      output.setUint8(i, input.getUint8(input.lengthInBytes - 1 - i));
      output.setUint8(input.lengthInBytes - 1 - i, input.getUint8(i));
    }
    return output;
  }

  static ByteData int16ToBytes(int x) {
    return ByteData(2)..setUint16(0, x);
  }

  static ByteData int8ToBytes(int x) {
    return ByteData(1)..setUint8(0, x);
  }

  static bool matchesMsbBits(ByteData opcode, int bits, int mask) {
    var x = opcode.getUint16(0) >> bits;
    return x == mask;
  }

  static int extractBits(ByteData data, int bitsFromEnd, int length) {
    // this '2' shouldn't be here. the word byte size is set elsewhere
    if(data.lengthInBytes != 2) throw ArgumentError('Must be 2 bytes');
    
    // clear the left bits
    var dataLenBits = data.lengthInBytes * 8;
    var leftBits = dataLenBits - bitsFromEnd;
    var x = data.getUint16(0) << leftBits;
    // this got quite ugly, but if I just shift left then right, the old value persists.
    var y = ByteUtilities.int16ToBytes(x);
    // clear the right bits
    return y.getUint16(0) >> (dataLenBits - length);
  }

  static int setBit(int i, int rightOffset) {
    return i | (0x1 << rightOffset);
  }

  static int clearBit(int i, int rightOffset) {
    return i & ~(0x1 << rightOffset);
  }

  static int getBit(int i, int rightOffset) {
    return ( i & (0x1 << rightOffset)) >> rightOffset;
  }

  // count bits from right, first bit is 1
  static int copyBits(int to, int from, int start, int len) {
    var x = extractBits(int16ToBytes(from), start, len);
    x = x << (start - len);
    return to | x;
  }
}