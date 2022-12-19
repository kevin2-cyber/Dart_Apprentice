
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Styles {
  static TextStyle productRowItemName = GoogleFonts.poppins(
    color: const Color.fromRGBO(0, 0, 0, 0.8),
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static TextStyle productRowTotal = GoogleFonts.poppins(
    color: const Color.fromRGBO(0, 0, 0, 0.8),
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static TextStyle productRowItemPrice = GoogleFonts.poppins(
    color: const Color(0xFF8E8E93),
    fontSize: 13,
    fontWeight: FontWeight.w300,
  );

  static TextStyle searchText = GoogleFonts.poppins(
    color: const Color.fromRGBO(0, 0, 0, 1),
    fontSize: 14,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static TextStyle deliveryTimeLabel = GoogleFonts.poppins(
    color: const Color(0xFFC2C2C2),
    fontWeight: FontWeight.w300,
  );

  static TextStyle deliveryTime = GoogleFonts.poppins(
    color: CupertinoColors.inactiveGray,
  );

  static const Color productRowDivider = Color(0xFFD9D9D9);

  static const Color scaffoldBackground = Color(0xfff0f0f0);

  static const Color searchBackground = Color(0xffe0e0e0);

  static const Color searchCursorColor = Color.fromRGBO(0, 122, 255, 1);

  static const Color searchIconColor = Color.fromRGBO(128, 128, 128, 1);

}