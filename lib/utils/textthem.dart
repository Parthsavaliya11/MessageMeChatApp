import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle headerTextStyle(Color color) {
  return GoogleFonts.poppins(textStyle: TextStyle(fontSize: 20, color: color));
}

TextStyle titleTextStyle(Color color, double size) {
  return GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: size,
      color: color,
      overflow: TextOverflow.clip,
    ),
  );
}

TextStyle simpleTextStyle(Color color, double size, {FontWeight? fw}) {
  return GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: size,
      color: color,
      fontWeight: fw,
      overflow: TextOverflow.clip,
    ),
  );
}
