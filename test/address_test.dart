import 'package:pic_dart_emu/Address.dart';
import 'package:test/test.dart';

void main() {
  test('asInt', () {
    var a = Address.fromInt(0x0400);

    expect(a.asInt(), 1024);
  });

  test('lessThan int', () {
    var a = Address.fromInt(0x0400);

    expect(a < '0500', true);
  });

  test('greaterThanInt', () {
    var a = Address.fromInt(0x0400);

    expect(a > '00FF', true);
  });

  test('increment', () {
    var a = Address.fromInt(0x0400);
    a.increment();
    expect(a.address.getUint16(0), 1025);
  });
}
