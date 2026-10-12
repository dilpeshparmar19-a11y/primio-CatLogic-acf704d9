import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color success;
  final Color warning;
  final Color danger;
  final Color subtleText;
  final Color cardHighlight;
  final Color boardBackground;
  final Color headerGradientStart;
  final Color headerGradientEnd;
  final Color onHeaderGradient;
  final Color chipBackground;
  final Color chipBorder;

  const AppColorsExtension({
    required this.success,
    required this.warning,
    required this.danger,
    required this.subtleText,
    required this.cardHighlight,
    required this.boardBackground,
    required this.headerGradientStart,
    required this.headerGradientEnd,
    required this.onHeaderGradient,
    required this.chipBackground,
    required this.chipBorder,
  });

  @override
  AppColorsExtension copyWith({
    Color? success,
    Color? warning,
    Color? danger,
    Color? subtleText,
    Color? cardHighlight,
    Color? boardBackground,
    Color? headerGradientStart,
    Color? headerGradientEnd,
    Color? onHeaderGradient,
    Color? chipBackground,
    Color? chipBorder,
  }) =>
      AppColorsExtension(
        success: success ?? this.success,
        warning: warning ?? this.warning,
        danger: danger ?? this.danger,
        subtleText: subtleText ?? this.subtleText,
        cardHighlight: cardHighlight ?? this.cardHighlight,
        boardBackground: boardBackground ?? this.boardBackground,
        headerGradientStart: headerGradientStart ?? this.headerGradientStart,
        headerGradientEnd: headerGradientEnd ?? this.headerGradientEnd,
        onHeaderGradient: onHeaderGradient ?? this.onHeaderGradient,
        chipBackground: chipBackground ?? this.chipBackground,
        chipBorder: chipBorder ?? this.chipBorder,
      );

  @override
  AppColorsExtension lerp(covariant ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      subtleText: Color.lerp(subtleText, other.subtleText, t)!,
      cardHighlight: Color.lerp(cardHighlight, other.cardHighlight, t)!,
      boardBackground: Color.lerp(boardBackground, other.boardBackground, t)!,
      headerGradientStart: Color.lerp(headerGradientStart, other.headerGradientStart, t)!,
      headerGradientEnd: Color.lerp(headerGradientEnd, other.headerGradientEnd, t)!,
      onHeaderGradient: Color.lerp(onHeaderGradient, other.onHeaderGradient, t)!,
      chipBackground: Color.lerp(chipBackground, other.chipBackground, t)!,
      chipBorder: Color.lerp(chipBorder, other.chipBorder, t)!,
    );
  }
}

class AppTheme {
  AppTheme._();

  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;

  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXl = 20.0;

  static const double iconSm = 16.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;

  static const double borderDefault = 1.0;
  static const double borderSelected = 2.0;

  static const double opacityDisabled = 0.38;
  static const double opacityHint = 0.6;
  static const double opacityOverlay = 0.7;

  // Region colors for the puzzle board
  static const List<Color> regionColors = [
    Color(0xFFFAC2C2), // soft pink
    Color(0xFFFCE29B), // soft yellow
    Color(0xFFA9E8C7), // soft green
    Color(0xFFAECBFA), // soft blue
    Color(0xFFD3C4F9), // soft purple
    Color(0xFFF6BEDD), // soft rose
    Color(0xFFFBCA9A), // soft orange
    Color(0xFF93E6D8), // soft teal
    Color(0xFFC0C9FB), // soft indigo
  ];

  static final ThemeData lightTheme = _buildTheme(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFFF7A5C),
      brightness: Brightness.light,
      primary: const Color(0xFFFF7A5C),
      onPrimary: Colors.white,
      secondary: const Color(0xFF6E8FFB),
      surface: const Color(0xFFFFFCF8),
      onSurface: const Color(0xFF2B2620),
    ),
    appColors: const AppColorsExtension(
      success: Color(0xFF4CAF50),
      warning: Color(0xFFF59E0B),
      danger: Color(0xFFEF4757),
      subtleText: Color(0xFF9C9186),
      cardHighlight: Color(0xFFFFF3EC),
      boardBackground: Color(0xFFF3ECE3),
      headerGradientStart: Color(0xFFFF9270),
      headerGradientEnd: Color(0xFFFF6A88),
      onHeaderGradient: Colors.white,
      chipBackground: Color(0xFFFFF6F0),
      chipBorder: Color(0xFFFFDCC9),
    ),
  );

  static ThemeData _buildTheme({
    required ColorScheme colorScheme,
    required AppColorsExtension appColors,
  }) {
    final textTheme = _buildTextTheme(colorScheme);
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: textTheme.titleLarge,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusXl),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusLarge),
          ),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          textStyle: textTheme.labelLarge,
          elevation: 0,
        ),
      ),
      extensions: [appColors],
    );
  }

  static TextTheme _buildTextTheme(ColorScheme colorScheme) {
    final base = GoogleFonts.nunitoTextTheme();
    return base.copyWith(
      headlineLarge: base.headlineLarge?.copyWith(
        fontWeight: FontWeight.w800,
        color: colorScheme.onSurface,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        fontWeight: FontWeight.w700,
        color: colorScheme.onSurface,
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
        color: colorScheme.onSurface,
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      bodyLarge: base.bodyLarge?.copyWith(color: colorScheme.onSurface),
      bodyMedium: base.bodyMedium?.copyWith(color: colorScheme.onSurface),
      bodySmall: base.bodySmall?.copyWith(color: colorScheme.onSurface),
      labelLarge: base.labelLarge?.copyWith(
        fontWeight: FontWeight.w700,
        color: colorScheme.onSurface,
      ),
      labelMedium: base.labelMedium?.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
    );
  }
}
