import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty_app/core/theme/app_colors.dart';

class AppTextStyles {
  static final TextStyle characterName = GoogleFonts.inter(
    color: AppColors.textHighlight,
    fontWeight: FontWeight.w900,
    fontSize: 22,
  );

  static final TextStyle cardLabel = GoogleFonts.inter(
    color: AppColors.textSecondary,
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );

  static final TextStyle cardValue = GoogleFonts.inter(
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );

  static final TextStyle errorMessage = GoogleFonts.inter(
    color: AppColors.textError,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
}
