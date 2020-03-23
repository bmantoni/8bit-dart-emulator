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
}