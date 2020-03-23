import 'package:pic_dart_emu/ByteUtilities.dart';
import 'package:pic_dart_emu/HexUtilities.dart';
import 'package:pic_dart_emu/InstructionSet.dart';
import 'package:test/test.dart';

void main() {
  var testInstr = Instruction(Instructions.movlw, 10, 12, (d, m) => print('movlw'));

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
}
