import 'package:pic_dart_emu/hexparser/HexUtilities.dart';

/*
 * For parsing IntelHex files (not hex stuff in general) 
*/
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

  int get intValue => HexUtilities.hexToInt(_val);
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
