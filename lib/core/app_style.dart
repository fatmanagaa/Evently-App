import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppStyles {

  static TextStyle bold20Black = GoogleFonts.inter(
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: AppColors.mainText,
  );
  static TextStyle bold16secText = GoogleFonts.inter(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: AppColors.secText,
  );
  static TextStyle bold18mainColor = GoogleFonts.inter(
    fontWeight: FontWeight.w500,
    fontSize: 18,
    color: AppColors.main,
  );

  static TextStyle bold20White = GoogleFonts.inter(
    fontWeight: FontWeight.w500,
    fontSize: 20,
    color: AppColors.white,
  );
  static TextStyle bold24Main = GoogleFonts.inter(
    fontWeight: FontWeight.w600,
    fontSize: 24,
    color: AppColors.main,
  );
  static TextStyle bold14Main = GoogleFonts.inter(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: AppColors.main,
  );

}
