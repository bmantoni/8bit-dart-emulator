import 'dart:typed_data';

import 'package:pic_dart_emu/ByteUtilities.dart';
import 'package:pic_dart_emu/HexUtilities.dart';
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
    expect(m.getUint16(0), 0xD7);
  });

  test('extract last 4 bits', () {
    var opcode = ByteUtilities.int16ToBytes(0x6D7);
    var m = ByteUtilities.extractBits(opcode, 4, 4);
    expect(m.getUint16(0), 0x7);
  });

  test('extract middle 8 bits', () {
    var opcode = ByteUtilities.int16ToBytes(0x26D7);
    var m = ByteUtilities.extractBits(opcode, 12, 8);
    expect(m.getUint16(0), 0x6D);
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
}
