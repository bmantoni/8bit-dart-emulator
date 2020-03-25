import 'dart:io';

import 'package:pic_dart_emu/Address.dart';
import 'package:pic_dart_emu/ByteUtilities.dart';
import 'package:test/test.dart';

void main() {
  test('asInt', () {
    var a = Address.fromString('0400');

    expect(a.asInt(), 1024);
  });

  test('lessThan int', () {
    var a = Address.fromString('0400');

    expect(a < '0500', true);
  });

  test('greaterThanInt', () {
    var a = Address.fromString('0400');

    expect(a > '00FF', true);
  });

  test('increment', () {
    var a = Address.fromString('0400');
    a.increment();
    expect(a.address.getUint16(0), 1025);
  });
}
