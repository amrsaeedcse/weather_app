import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/helpers/theme/app_colors.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    required this.weight,
    required this.size,
    this.color,
  });
  final String text;
  final FontWeight weight;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: true,
      style: GoogleFonts.aBeeZee(
        fontWeight: weight,
        fontSize: size,
        color: color ?? AppColors.textPrimary,
      ),
    );
  }
}
