part of 'theme_control_cubit.dart';

@immutable
sealed class ThemeControlState {}

final class ThemeControlValue extends ThemeControlState {
  Color color;
  ThemeControlValue(this.color);
}
