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
}
