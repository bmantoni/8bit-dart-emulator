class Stack<T> {
  final List<T> _stack = <T>[];
  int _max;

  Stack({int maxElements = -1}) {
    _max = maxElements;
  }

  T pop() {
    var o = _stack[0];
    _stack.removeAt(0);
    return o;
  }

  bool get hasValue => _stack.isNotEmpty;

  void push(T a) {
    if (_max >= 0 && _stack.length >= _max) {
      throw ArgumentError('Reached stack max!');
    }
    _stack.insert(0, a);
  }
}