library runner;

import 'dart:io';

import 'package:args/args.dart';
import 'package:pic_dart_emu/IntelHexParser.dart';
import 'package:pic_dart_emu/PIC.dart';

class ProgramRunner {
  static final String PROGRAM_ARG = 'program-file';

  HexParser parser;
  PIC computer;

  int run(List<String> arguments) {
    final argParser = ArgParser()
      ..addOption(PROGRAM_ARG,
          abbr: 'p',
          callback: (p) => {
                if (p == null) throw ArgumentError('file argument is missing!')
              });

    final args = argParser.parse(arguments);
    runProgram(args[PROGRAM_ARG]);

    return 0;
  }

  void runProgram(String file) {
    print('Running program: ${file}!');
    parser = HexParser(File(file));
  }
}
