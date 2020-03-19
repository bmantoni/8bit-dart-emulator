class HexComponent {
  String _val;
  final int _len;

  HexComponent(this._len);

  String get value => _val;
  set value(String val) {
    if (val.length != _len) {
      throw ArgumentError('Must be ${_len} characters');
    }
    _val = val;
  }

  int get intValue => hexToInt(_val);

  int get eightBitAddressValue => hexAddrTo8BitAddr(intValue);

  // The hex format stored 8 bit addresses as 16 bit values, so are effectively doubled.
  // so this should always be integer division, so safe to use truncating division
  static int hexAddrTo8BitAddr(int sixteenBitAddr) {
    return sixteenBitAddr ~/ 2;
  }

  static int hexToInt(String str) {
    return int.parse(str, radix: 16);
  }
}

class HexLine {
  final HexComponent byteCount = HexComponent(2);
  final HexComponent address = HexComponent(4);
  final HexComponent recordType = HexComponent(2);
  HexComponent data;

  HexLine(String line) {
    byteCount.value = line.substring(1, 3);
    address.value = line.substring(3, 7);
    recordType.value = line.substring(7, 9);
    final dataHexCharLen = byteCount.intValue * 2;
    data = HexComponent(dataHexCharLen)
      ..value = line.substring(9, 9 + dataHexCharLen);
  }

  int getDataByte(int byteOffset) {
    var byteStr = data.value.substring(byteOffset * 2, byteOffset * 2 + 2);
    return int.parse(byteStr, radix: 16);
  }
}
