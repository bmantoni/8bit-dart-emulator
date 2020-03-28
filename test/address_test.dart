import 'dart:typed_data';

import 'package:pic_dart_emu/Address.dart';
import 'package:test/test.dart';

void main() {
  test('asInt', () {
    var a = Address.fromInt(0x0400);

    expect(a.asInt(), 1024);
  });

  test('set address', () {
    var a = Address.fromInt(0x0);
    a.address = ByteData(Address.SIZE)..setUint16(0, 0x4);
    expect(a.asInt(), 4);
  });

  test('set address', () {
    var a = Address.fromInt(0x0);
    expect(() => { a.address = ByteData(3) }, throwsArgumentError);
  });
  
  test('address from address', () {
    var a = Address(ByteData(Address.SIZE)..setUint16(0, 0x4));
    expect(a.asInt(), 4);
  });

  test('lessThan int', () {
    var a = Address.fromInt(0x0400);

    expect(a < '0500', true);
  });

  test('lessThanEqualTo int', () {
    var a = Address.fromInt(0x0400);

    expect(a <= '0400', true);
    expect(a <= '0401', true);
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
