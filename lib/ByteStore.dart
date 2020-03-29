import 'dart:typed_data';

abstract class ByteStore {
  void setByte(int offset, int value);
  int getByte(int offset);
  void updateByte(int offset, int Function(int) f);
  ByteData getBytes(int offset, int len);
}