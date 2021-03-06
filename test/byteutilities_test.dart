import 'dart:typed_data';

import 'package:pic_dart_emu/ByteUtilities.dart';
import 'package:pic_dart_emu/hexparser/HexUtilities.dart';
import 'package:test/test.dart';

void main() {

  test('swap 2 bytes', () {
    var str = '30DF';
    var out = ByteUtilities.swapBytes(HexUtilities.hexToBytes(str));
    expect(HexUtilities.bytesToHex(out), 'DF30');
  });

  test('swap 4 bytes', () {
    var str = '30DFA2C4';
    var out = ByteUtilities.swapBytes(HexUtilities.hexToBytes(str));
    expect(HexUtilities.bytesToHex(out), 'C4A2DF30');
  });

  test('matches movlw with the rest 0s', () {
    // 11000000000000  : movlw
    var opcode = ByteData(2)..setUint16(0, 12288);
    var m = ByteUtilities.matchesMsbBits(opcode, 10, 12);
    expect(m, true);
  });

  test('doesnt match movlw', () {
    // 11010000000000  : not movlw
    var opcode = ByteData(2)..setUint16(0, 13312);
    var m = ByteUtilities.matchesMsbBits(opcode, 10, 12);
    expect(m, false);
  });

  test('doesnt match movlw when zeroes', () {
    // 00000000000000  : not movlw
    var opcode = ByteData(2)..setUint16(0, 0);
    var m = ByteUtilities.matchesMsbBits(opcode, 10, 12);
    expect(m, false);
  });

  test('extract last 8 bits', () {
    var opcode = ByteUtilities.int16ToBytes(0x6D7);
    var m = ByteUtilities.extractBits(opcode, 8, 8);
    expect(m, 0xD7);
  });

  test('extract last 4 bits', () {
    var opcode = ByteUtilities.int16ToBytes(0x6D7);
    var m = ByteUtilities.extractBits(opcode, 4, 4);
    expect(m, 0x7);
  });

  test('extract middle 8 bits', () {
    var opcode = ByteUtilities.int16ToBytes(0x26D7);
    var m = ByteUtilities.extractBits(opcode, 12, 8);
    expect(m, 0x6D);
  });

  // TODO more tests for smaller numbers of bits

  test('set bit 1', () {
    var m = ByteUtilities.setBit(0x1, 1);
    expect(m, 0x3);
  });  

  test('set bit 0', () {
    var m = ByteUtilities.setBit(0x4, 0);
    expect(m, 0x5);
  });

  test('clear bit 0, 1', () {
    var m = ByteUtilities.clearBit(0x1, 0);
    expect(m, 0x0);
  });

  test('clear bit 0, 3', () {
    var m = ByteUtilities.clearBit(0x3, 0);
    expect(m, 0x2);
  });

  test('clear bit 1, 3', () {
    var m = ByteUtilities.clearBit(0x3, 1);
    expect(m, 0x1);
  });

  test('clear bit 1, 5 (0 stays 0)', () {
    var m = ByteUtilities.clearBit(0x5, 1);
    expect(m, 0x5);
  });

  test('get bit 0, true', () {
    var m = ByteUtilities.getBit(0x3, 0);
    expect(m, 1);
  });

  test('get bit 1, true', () {
    var m = ByteUtilities.getBit(0x3, 0);
    expect(m, 1);
  });

  test('get bit 0, false', () {
    var m = ByteUtilities.getBit(0x4, 0);
    expect(m, 0);
  });

  test('get bit 2, false', () {
    var m = ByteUtilities.getBit(0x4, 2);
    expect(m, 1);
  });

  test('copybits 1', () {
    var x = 0x20;
    var y = 0x10;
    var out = ByteUtilities.copyBits(y, x, 7, 2);
    expect(out, 0x30);
  });

  test('copybits 2', () {
    var x = 0x2;
    var y = 0x1;
    var out = ByteUtilities.copyBits(y, x, 2, 1);
    expect(out, 0x3);
  });

  test('copybits 3', () {
    var x = 0x2;
    var y = 0x1;
    var out = ByteUtilities.copyBits(x, y, 1, 1);
    expect(out, 0x3);
  });

  test('copy 11 bits ', () {
    var x = 0x6F7;
    var y = 0x1001;
    var out = ByteUtilities.copyBits(y, x, 11, 11);
    expect(out, 0x16F7);
  });
}
