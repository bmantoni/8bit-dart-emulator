import 'package:pic_dart_emu/HexUtilities.dart';
import 'package:pic_dart_emu/InstructionSet.dart';
import 'package:pic_dart_emu/Memory.dart';
import 'package:test/test.dart';

void main() {
  var testInstr = Instruction(Instructions.movlw, 10, 12, (d, m) => print('movlw'));

  test('match msb', () {
    var str = '30DF'; // assume bytes reversed by now.

    expect(testInstr.matches(HexUtilities.hexToBytes(str)), true);
  });

  test('match msb, less significant bytes dont matter', () {
    var str = '30FF';

    expect(testInstr.matches(HexUtilities.hexToBytes(str)), true);
  });

  test('dont match msb when wrong', () {
    var str = 'E0FF';

    expect(testInstr.matches(HexUtilities.hexToBytes(str)), false);
  });
  
  test('movlw matches', () {
    var insBytes = HexUtilities.hexToBytes('DF30');
    var i = InstructionSet().run(insBytes, Memory());

    expect(i.name.toString(), 'Instructions.movlw');
  });
}
