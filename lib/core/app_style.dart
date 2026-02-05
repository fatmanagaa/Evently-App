import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppStyles {

  static TextStyle semi20Black = GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: AppColors.mainText,
  );
  static TextStyle semi20Primary = GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: AppColors.mainText,
  );
  static TextStyle medium16Black = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppColors.mainText,
  );
  static TextStyle medium16White = GoogleFonts.inter(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppColors.white,
  );

  static TextStyle semi20White = GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: AppColors.white,
  );
  static TextStyle bold24Main = GoogleFonts.inter(
    fontWeight: FontWeight.w600,
    fontSize: 24,
    color: AppColors.main,
  );
  static TextStyle regular14White = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.whiteDarkColor,
  );
  static TextStyle regular14Grey = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.greyColor,
  );


}
