import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/controllers/page/pagecontrol_cubit.dart';
import 'package:weather_app/controllers/theme/theme_control_cubit.dart';
import 'package:weather_app/controllers/weather/weather_control_cubit.dart';
import 'package:weather_app/helpers/theme/app_colors.dart';
import 'package:weather_app/views/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WeatherControlCubit()),
        BlocProvider(create: (context) => ThemeControlCubit()),
        BlocProvider(create: (context) => PagecontrolCubit()),
      ],
      child: BlocBuilder<ThemeControlCubit, ThemeControlState>(
        builder: (context, state) {
          return MaterialApp(
            themeAnimationCurve: Curves.linear,
            themeAnimationDuration: Duration(milliseconds: 500),
            theme: ThemeData(primaryColor: (state as ThemeControlValue).color),
            debugShowCheckedModeBanner: false,
            home: HomePage(),
          );
        },
      ),
    );
  }
}
