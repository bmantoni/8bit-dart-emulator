import 'package:pic_dart_emu/Stack.dart';
import 'package:test/test.dart';

void main() {
  test('push and pop 1, default constructor', () async {
    var s = Stack();
    s.push('test');
    expect(s.pop(), 'test');
  });

  test('push and pop 2, default constructor', () async {
    var s = Stack();
    s..push('test')
     ..push('two');
    expect(s.pop(), 'two');
  });

  test('push and pop 2, max constructor', () async {
    var s = Stack(maxElements: 2);
    s..push('test')
     ..push('two');
    expect(s.pop(), 'two');
  });

  test('push and pop 2, max error', () async {
    var s = Stack(maxElements: 1);
    s.push('test');
    expect(() => s.push('two'), throwsArgumentError);
  });

  test('push and pop 3, right order', () async {
    var s = Stack(maxElements: 3);
    s..push('one')
     ..push('two')
     ..push('three');
    expect(s.hasValue, true);
    expect(s.pop(), 'three');
    expect(s.pop(), 'two');
    expect(s.pop(), 'one');
    expect(s.hasValue, false);
  });
}
