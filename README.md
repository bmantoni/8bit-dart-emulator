
![Dart CI](https://github.com/bmantoni/8bit-dart-emulator/workflows/Dart%20CI/badge.svg)
[![Coverage Status](https://coveralls.io/repos/github/bmantoni/8bit-dart-emulator/badge.svg?branch=master)](https://coveralls.io/github/bmantoni/8bit-dart-emulator?branch=master)

An emulator for the PIC12F629 8-bit microcontroller written in Dart.

Takes as input a hex-encoded program just like you would program into the micro with a Pickit programmer. Example test programs [here](https://github.com/bmantoni/8bit-dart-emulator/blob/master/test/programs/test1.hex).

In my setup, it runs about 5x faster in real-time than the PIC does for a given program.

More details [here](http://bmantoni.github.io/pic-emulator-part-1/).

# Building
[Install Dart](https://dart.dev/get-dart), then `pub get`.

# Running
`pub run test` will run unit tests and the 3 included PIC programs. It also has a CLI - see `runner.dart`.

# Compiling new PIC input programs
I have 3 test programs already compiled from C to hex in here, but if you want to create a new one, you'll need the XC8 compiler from [here](https://www.microchip.com/mplab/compilers).

