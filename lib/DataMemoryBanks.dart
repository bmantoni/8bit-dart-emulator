import 'dart:typed_data';

import 'package:pic_dart_emu/ByteStore.dart';
import 'package:pic_dart_emu/ByteUtilities.dart';

class DataMemory extends ByteStore {

  static const int DATA_BANK_SIZE = 128;

  static const int NUM_BANKS = 2;
  static const int BANK_SIZE_BYTES = 256; // 128 or 256 ?

  static const int STATUS_ADDR = 0x3;

  List<ByteData> _memories;

  DataMemory() {
    _memories = Iterable<ByteData>.generate(NUM_BANKS, 
      (i) => ByteData(BANK_SIZE_BYTES)).toList();
  }

  // I'm going to treat Bank0.status as _the_ status, and ignore Bank1.status
  int get registerStatus => _memories[0].getUint8(STATUS_ADDR); 

  ByteData getBank(int num) {
    return _memories[num];
  }

  int get _currentBankNum => ByteUtilities.getBit(registerStatus, 5);
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