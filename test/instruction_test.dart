import 'package:pic_dart_emu/ByteUtilities.dart';
import 'package:pic_dart_emu/InstructionLib.dart';
import 'package:pic_dart_emu/InstructionSet.dart';
import 'package:pic_dart_emu/Memory.dart';
import 'package:test/test.dart';

void main() {
  var testInstr = MovLwInstruction();

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
    var insBytes = ByteUtilities.int16ToBytes(0xDF30);
    var i = InstructionSet().run(insBytes, Memory());

    expect(i.name.toString(), 'Instructions.movlw');
  });

  test('movlw sets w (accumulator)', () {
    final memory = Memory();
    var insBytes = ByteUtilities.int16ToBytes(0xDF30);
    InstructionSet().run(insBytes, memory);

    expect(memory.w, 223);
  });

  test('movwlw then movwf sets register', () {
    final memory = Memory();
    // load 223 to W
    var insBytes = ByteUtilities.int16ToBytes(0xDF30);
    InstructionSet().run(insBytes, memory);
    // move W to f
    insBytes = ByteUtilities.int16ToBytes(0x8500);
    InstructionSet().run(insBytes, memory);

    expect(memory.getByte(MemoryTypes.Data, 0x5), 223);
  });
}
