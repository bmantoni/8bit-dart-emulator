import 'package:pic_dart_emu/runner.dart';
import 'package:test/test.dart';

void main() {
  test('file arg present', () async {
    //expect(calculate(), 42);
    await ProgramRunner().run(['--' + ProgramRunner.PROGRAM_ARG, './test/programs/test1.hex']);
  });

  test('file arg missing', () async {
    expect(() async => await ProgramRunner().run([]), throwsArgumentError);
  });
}
