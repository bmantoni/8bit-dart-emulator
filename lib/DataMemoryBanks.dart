import 'dart:typed_data';

import 'package:pic_dart_emu/ByteStore.dart';

class DataMemory extends ByteStore {

  static const int DATA_BANK_SIZE = 128;

  static const int NUM_BANKS = 2;
  static const int BANK_SIZE_BYTES = 256; // 128 or 256 ?

  List<ByteData> _memories;

  DataMemory() {
    _memories = Iterable<ByteData>.generate(NUM_BANKS, 
      (i) => ByteData(BANK_SIZE_BYTES)).toList();
  }

  ByteData getBank(int num) {
    return _memories[num];
  }

  // TODO switch bank based on STATUS
  int get _currentBankNum => 0;
  ByteData get _currentBank => _memories[_currentBankNum];

  @override
  int getByte(int offset) {
    return _currentBank.getUint8(offset);
  }

  @override
  ByteData getBytes(int offset, int len) {
    return _currentBank.buffer.asByteData(offset, len);
  }

  @override
  void setByte(int offset, int value) {
    _currentBank.setUint8(offset, value);
  }
}