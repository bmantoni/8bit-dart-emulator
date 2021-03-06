import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:pic_dart_emu/hexparser/HexLine.dart';

/* Parser for the IntelHex file format (ASCII encoded binary) outputted by the XC8 compiler.
 * Yields an instruction until done.
 * could get fancy and validate the CRC
 */
class HexParser {
  
  File inFile;

  HexParser(this.inFile);

  Future start(onInstruction) {
    print('Here ${inFile.existsSync()}');
    
    var inputStream = inFile.openRead();

    return inputStream
      .transform(ascii.decoder)
      .transform(LineSplitter())
      .map((String lineStr) => HexLine(lineStr))
      .forEach(onInstruction);
  }
}