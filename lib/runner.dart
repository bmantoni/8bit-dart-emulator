library runner;

import 'package:args/args.dart';

const String PROGRAM_ARG = 'program-file';

int run(List<String> arguments) {
  final argParser = ArgParser()
    ..addOption(PROGRAM_ARG, abbr: 'p', 
    callback: (p) => { if (p == null) throw ArgumentError('file argument is missing!')});
  
  final args = argParser.parse(arguments);
  runProgram(args[PROGRAM_ARG]); 
  
  return 0;
}

void runProgram(String file) {
  print('Running program: ${file}!');
  //pic_dart_emu.calculate()
}