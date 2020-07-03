library runner;

import 'dart:io';

import 'package:args/args.dart';
import 'package:pic_dart_emu/PIC.dart';
import 'package:pic_dart_emu/ProgramLoader.dart';

class ProgramRunner {
  static final String PROGRAM_ARG = 'program-file';

  ProgramLoader loader;
  PIC computer = PIC();

  Future<int> run(List<String> arguments) async {
    final argParser = ArgParser()
      ..addOption(PROGRAM_ARG,
          abbr: 'p',
          callback: (p) => {
                if (p == null) throw ArgumentError('file argument is missing!')
              });

    final args = argParser.parse(arguments);
    var start = DateTime.now();

    await runProgram(args[PROGRAM_ARG]);

    var end = DateTime.now();
    print('Execution time: ${end.difference(start).inMilliseconds}');

    return 0;
  }

  void runProgram(String file) async {
    print('Running program: ${file}!');
    
    loader = ProgramLoader(File(file));
    await loader.load(computer.memory);
    computer.run();
  }

  void runProgramString(String program) async {
    print('Running program String: ${program}!');
    
    loader = ProgramLoader.fromProgramString(program);
    await loader.load(computer.memory);
    computer.run();
  }
}
