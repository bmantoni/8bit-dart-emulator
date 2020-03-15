import 'dart:typed_data';

class Memory {

  static const int PROGRAM_DATA_SIZE = 1024;

  ByteData programData = ByteData(PROGRAM_DATA_SIZE); // 0x000 - 0x0400
}