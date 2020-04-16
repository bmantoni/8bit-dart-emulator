import 'dart:math';

import 'package:pic_dart_emu/ByteUtilities.dart';
import 'package:pic_dart_emu/InstructionLib.dart';
import 'package:pic_dart_emu/InstructionSet.dart';
import 'package:pic_dart_emu/Memory.dart';
import 'package:pic_dart_emu/PIC.dart';
import 'package:test/test.dart';

// For all the instruction tests, remember to swap the bytes
void main() {
  var testInstr = MovLw();

  test('match msb', () {
    expect(testInstr.matches(ByteUtilities.int16ToBytes(0x30DF)), true);
  });

  test('match msb, less significant bytes dont matter', () {
    expect(testInstr.matches(ByteUtilities.int16ToBytes(0x30FF)), true);
  });

  test('dont match msb when wrong', () {
    expect(testInstr.matches(ByteUtilities.int16ToBytes(0xE0FF)), false);
  });
  
  test('movlw matches', () {
    var insBytes = ByteUtilities.int16ToBytes(0x30DF);
    var i = InstructionSet().getMatchingInstr(insBytes);

    expect(i.name.toString(), 'Instructions.movlw');
  });

  test('movlw sets w (accumulator)', () {
    final memory = Memory();
    var insBytes = ByteUtilities.int16ToBytes(0xDF30);
    InstructionSet().run(insBytes, memory);

    expect(memory.w, 223);
  });

  test('movlw then movwf sets register', () {
    final memory = Memory();
    // load 223 to W
    var insBytes = ByteUtilities.int16ToBytes(0xDF30);
    InstructionSet().run(insBytes, memory);
    // move W to f
    insBytes = ByteUtilities.int16ToBytes(0x8500);
    InstructionSet().run(insBytes, memory);

    expect(memory.data.getByte(0x5), 223);
  });

  test('bsf sets bit', () {
    final memory = Memory();
    var insBytes = ByteUtilities.int16ToBytes(0x8316);
    InstructionSet().run(insBytes, memory);

    expect(memory.data.registerStatus, pow(2, 5));
  });

  test('bcf clears bit', () {
    final memory = Memory();

    // first, set it
    var insBytes = ByteUtilities.int16ToBytes(0x8316);
    InstructionSet().run(insBytes, memory);
    expect(memory.data.registerStatus, pow(2, 5));

    // now, clear it
    insBytes = ByteUtilities.int16ToBytes(0x8312);
    InstructionSet().run(insBytes, memory);

    expect(memory.data.registerStatus, 0);
  });

  test('decfsz sets f when it should', () {
    final memory = Memory();
    memory.data.setByte(0x20, 10);
    var insBytes = ByteUtilities.int16ToBytes(0xA00B); // d: 1, f: 0x20
    InstructionSet().run(insBytes, memory);

    expect(memory.data.getByte(0x20), 9);
  });

  test('decfsz sets w when it should', () {
    final memory = Memory();
    memory.data.setByte(0x20, 10);
    memory.w = 0x8;
    var insBytes = ByteUtilities.int16ToBytes(0x200B); // d: 1, f: 0x20
    InstructionSet().run(insBytes, memory);

    expect(memory.data.getByte(0x20), 10);
    expect(memory.w, 9);
  });

  test('decfsz returns skip when it should', () {
    final memory = Memory();
    memory.data.setByte(0x20, 1);
    var insBytes = ByteUtilities.int16ToBytes(0xA00B); // d: 1, f: 0x20
    var cf = InstructionSet().run(insBytes, memory);

    expect(cf.skip, true);
  });

  test('goto returns goto address', () {
    final memory = Memory();
    var insBytes = ByteUtilities.int16ToBytes(0xE62B); // d: 1, f: 0x20
    var cf = InstructionSet().run(insBytes, memory);

    expect(cf.goto, 0x3E6);
  });

  test('addwf puts result in register f when it should', () {
    final pic = PIC();
    final memory = pic.memory;
    memory.w = 10;
    memory.data.setByte(0x20, 32);
    var insBytes = ByteUtilities.int16ToBytes(0xA007); // d: 1, f: 0x20
    InstructionSet().run(insBytes, memory);

    expect(memory.data.getByte(0x20), 42);
  });

  test('addwf puts result in w when it should', () {
    final pic = PIC();
    final memory = pic.memory;
    memory.w = 10;
    memory.data.setByte(0x20, 32);
    var insBytes = ByteUtilities.int16ToBytes(0x2007); // d: 1, f: 0x20
    InstructionSet().run(insBytes, memory);

    expect(memory.w, 42);
  });

  test('incf puts result in register f when it should', () {
    final pic = PIC();
    final memory = pic.memory;
    memory.data.setByte(0x20, 32);
    var insBytes = ByteUtilities.int16ToBytes(0xA00A); // d: 1, f: 0x20
    InstructionSet().run(insBytes, memory);

    expect(memory.data.getByte(0x20), 33);
  });

  test('incf puts result in w when it should', () {
    final pic = PIC();
    final memory = pic.memory;
    memory.data.setByte(0x20, 32);
    var insBytes = ByteUtilities.int16ToBytes(0x200A); // d: 0, f: 0x20
    InstructionSet().run(insBytes, memory);

    expect(memory.w, 33);
    expect(memory.data.getByte(0x20), 32);
  });
}
