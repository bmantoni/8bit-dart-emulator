import 'dart:io';

import 'package:pic_dart_emu/Memory.dart';
import 'package:pic_dart_emu/ProgramLoader.dart';
import 'package:test/test.dart';

void main() {
  //final lineStr = ':0A0000008316FF2390008312FD2BEE';

  test('can load program to memory', () async {
    var loader = ProgramLoader(File('./test/programs/test1.hex'));
    var memory = Memory();

    await loader.load(memory);
    //memory.debug(MemoryTypes.Program);

    // byte at 07B6 should be DF
    expect(memory.program.getByte(0x07B6), 0xDF);
  });
}
