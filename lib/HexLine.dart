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
}
  
  class HexLine {
    HexComponent byteCount = HexComponent(2);
    HexComponent address = HexComponent(4);
    HexComponent recordType = HexComponent(2);
    HexComponent data;
  
    HexLine(String line) {
      byteCount.value = line.substring(1, 3);
  }
}