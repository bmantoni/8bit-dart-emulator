import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:pic_dart_emu/hexparser/HexLine.dart';

/* Parser for the IntelHex file format (ASCII encoded binary) outputted by the XC8 compiler.
 * Yields an instruction until done.
 * could get fancy and validate the CRC
 */
class HexParser {
  
  File _inFile;
  String _inProgram;

  HexParser(this._inFile);
  HexParser.fromString(this._inProgram);

  void validate() {
    if (_inFile != null && !_inFile.existsSync()) {
      throw ArgumentError('Input file doesnt exist');
    }
    if (_inFile == null && _inProgram == null) {
      throw ArgumentError('Must provide either an input file or program string');
    }
  }

  void start(onInstruction) async {
    validate();
    
    if (_inFile != null) {
      await parseFile(onInstruction);
    } else {
      LineSplitter().convert(_inProgram)
        .map((String lineStr) => HexLine(lineStr))
        .forEach(onInstruction);
    }
  }

  Future parseFile(onInstruction) {
    var inputStream = _inFile.openRead();
    
    return inputStream
      .transform(ascii.decoder)
      .transform(LineSplitter())
      .map((String lineStr) => HexLine(lineStr))
      .forEach(onInstruction);
  }
}