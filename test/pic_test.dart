import 'dart:io';

import 'package:pic_dart_emu/PIC.dart';
import 'package:pic_dart_emu/ProgramLoader.dart';
import 'package:test/test.dart';

void main() {
  test('runs with empty memory', () {
    var p = PIC();
    p.run();
  });

  test('runs with test program', () async {
    var loader = ProgramLoader(File('./test/test1.hex'));    
    
    var p = PIC();
    await loader.load(p.memory);

    p.run();
  });
}
