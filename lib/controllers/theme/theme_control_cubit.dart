import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/helpers/theme/app_colors.dart';

part 'theme_control_state.dart';

class ThemeControlCubit extends Cubit<ThemeControlState> {
  ThemeControlCubit() : super(ThemeControlValue(AppColors.cloudy));

  changeColor(Color c) {
    emit(ThemeControlValue(c));
  }
}
