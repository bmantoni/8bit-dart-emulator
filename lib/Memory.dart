import 'dart:io';
import 'dart:typed_data';

class Memory {
  static const DEBUG_LINE_LENGTH = 30;

  static const int PROGRAM_DATA_SIZE = 1027; // TODO move this outside

  ByteData memory = ByteData(PROGRAM_DATA_SIZE); // 0x000 - 0x0400

  void setByte(int offset, int value) {
    //print('Setting ${offset} to ${value}');
    memory.setUint8(offset, value);
  }

  int getByte(int offset) {
    return memory.getUint8(offset);
  }

  void debug() {
    for(var i = 0; i < memory.lengthInBytes; ++i) {
      var hexStr = memory.getUint8(i).toRadixString(16);
      if (hexStr.length == 1) stdout.write('0');
      stdout.write(hexStr);
      stdout.write(' ');
      if (i > 0 && i % DEBUG_LINE_LENGTH == 0) stdout.write('\n');
    }
    stdout.write('\n');
  }
}