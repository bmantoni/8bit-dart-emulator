An emulator for the PIC12F629 8-bit microcontroller written in Dart.

![Dart CI](https://github.com/bmantoni/8bit-dart-emulator/workflows/Dart%20CI/badge.svg)
[![Coverage Status](https://coveralls.io/repos/github/bmantoni/8bit-dart-emulator/badge.svg?branch=master)](https://coveralls.io/github/bmantoni/8bit-dart-emulator?branch=master)

Run tests with `pub run test`.

Takes as input a hex-encoded program just like you would program into the micro with a Pickit programmer. Example test programs [here](https://github.com/bmantoni/8bit-dart-emulator/blob/master/test/programs/test1.hex).

Without delays, it runs about 5x faster than the PIC does for a given program.

More details [here](http://bmantoni.github.io/pic-emulator-part-1/).
