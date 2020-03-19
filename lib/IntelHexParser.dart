import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

// Parser for the IntelHex file format (ASCII encoded binary) outputted by the XC8 compiler.
// Yields an instruction until done.
// could get fancy and validate the CRC
// Skip startup code?
class HexParser {
  
  File inFile;

  HexParser(this.inFile);

  Future start(onInstruction) {
    print('Here ${inFile.existsSync()}');
    
    var inputStream = inFile.openRead();

    return inputStream
      .transform(ascii.decoder)
      .transform(LineSplitter())
      .forEach(onInstruction);
  }
}