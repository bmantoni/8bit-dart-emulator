import 'dart:typed_data';

import 'package:pic_dart_emu/ByteStore.dart';
import 'package:pic_dart_emu/ByteUtilities.dart';

class DataMemory extends ByteStore {

  static const int DATA_BANK_SIZE = 128;

  static const int NUM_BANKS = 2;
  static const int BANK_SIZE_BYTES = 256; // 128 or 256 ?

  static const int STATUS_ADDR = 0x3;
  static const int PCLATH_ADDR = 0x0A;

  static const List<int> _mappedAddresses = [0x02, 0x03, 0x04, 0x0A, 0x0B];

  List<ByteData> _memories;

  DataMemory() {
    _memories = Iterable<ByteData>.generate(NUM_BANKS, 
      (i) => ByteData(BANK_SIZE_BYTES)).toList();
  }

  // can't have a circular loop of checking which bank for this, so look at 1
  // they're kept in sync
  int get registerStatus => _memories[0].getUint8(STATUS_ADDR); 
  int get registerPclath => _memories[0].getUint8(PCLATH_ADDR);

  /*ByteData getBank(int num) {
    return _memories[num];
  }*/

  int get _currentBankNum => ByteUtilities.getBit(registerStatus, 5);
  ByteData get _currentBank => _memories[_currentBankNum];
  ByteData get _otherBank => _memories[_currentBankNum ^ 1];

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
    if (_mappedAddresses.contains(offset)) _otherBank.setUint8(offset, value);
  }

  @override
  void updateByte(int offset, int Function(int) f) {
    setByte(offset, f(getByte(offset)));
  }
}