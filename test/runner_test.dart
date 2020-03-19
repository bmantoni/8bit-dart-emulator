import 'package:pic_dart_emu/runner.dart';
import 'package:test/test.dart';

void main() {
  test('file arg present', () {
    //expect(calculate(), 42);
    ProgramRunner().run(['--' + ProgramRunner.PROGRAM_ARG, 'test.hex']);
  });

  test('file arg missing', () {
    expect(() => ProgramRunner().run([]), throwsArgumentError);
  });
}
