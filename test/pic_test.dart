import 'dart:io';

import 'package:pic_dart_emu/InstructionSet.dart';
import 'package:pic_dart_emu/PIC.dart';
import 'package:pic_dart_emu/ProgramLoader.dart';
import 'package:test/test.dart';

void main() {
  test('runs with empty memory', () {
    var p = PIC();
    p.run();
  });

  test('runs with test program', () async {
    var loader = ProgramLoader(File('./test/programs/test1.hex'));    
    
    var p = PIC();
    await loader.load(p.memory);

    p.run();
  });

  test('handles skip control true', () async {
    var p = PIC();
    p.nextInstruction(ControlFlow(skip: true));

    expect(p.pc.asInt(), 2);
  });

  test('handles skip control false', () async {
    var p = PIC();
    p.nextInstruction(ControlFlow.none());

    expect(p.pc.asInt(), 1);
  });
}
