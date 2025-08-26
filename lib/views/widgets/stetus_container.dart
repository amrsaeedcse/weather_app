import 'package:flutter/cupertino.dart';
import 'package:weather_app/helpers/theme/app_colors.dart';
import 'package:weather_app/helpers/wigets/custom_text.dart';

class StetusContainer extends StatelessWidget {
  const StetusContainer({
    super.key,
    required this.name,
    required this.icon,
    required this.disc,
  });
  final String name;
  final IconData icon;
  final String disc;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 25, color: AppColors.textPrimary),
        SizedBox(height: 5),
        CustomText(
          text: name,
          weight: FontWeight.w500,
          size: 12,
          color: AppColors.textSecondary,
        ),
        SizedBox(height: 2),
        CustomText(text: disc, weight: FontWeight.w500, size: 16),
      ],
    );
  }
}
