import 'package:pic_dart_emu/HexLine.dart';
import 'package:test/test.dart';

void main() {
  final lineStr = ':0A0000008316FF2390008312FD2BEE';

  test('can set byteCount', () {
    var line = HexLine(lineStr);
    expect(line.byteCount.value, '0A');
  });

  test('setting wrong length throws exception', () {
    var line = HexLine(lineStr);
    expect(() => { line.byteCount.value = '0A2' }, throwsArgumentError);
  });

  test('parses address', () {
    var line = HexLine(lineStr);
    expect(line.address.value, '0000');
  });

  test('parses recordType', () {
    var line = HexLine(lineStr);
    expect(line.recordType.value, '00');
  });

  test('parses data', () {
    var line = HexLine(lineStr);
    expect(line.data.value, '8316FF2390008312FD2B');
  });
}
