import 'package:pic_dart_emu/runner.dart' as runner;
import 'package:test/test.dart';

void main() {
  test('file arg present', () {
    //expect(calculate(), 42);
    runner.run(['--' + runner.PROGRAM_ARG, 'test.hex']);
  });

  test('file arg missing', () {
    expect(() => runner.run([]), throwsArgumentError);
  });
}
