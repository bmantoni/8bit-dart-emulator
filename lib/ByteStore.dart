import 'dart:typed_data';

abstract class ByteStore {
  void setByte(int offset, int value);
  int getByte(int offset);
  ByteData getBytes(int offset, int len);
}