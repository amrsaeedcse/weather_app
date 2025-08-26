import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/controllers/theme/theme_control_cubit.dart';
import 'package:weather_app/controllers/weather/weather_control_cubit.dart';
import 'package:weather_app/helpers/theme/app_colors.dart';
import 'package:weather_app/helpers/wigets/custom_text.dart';
import 'package:weather_app/models/weather/weather_model.dart';
import 'package:weather_app/views/widgets/stetus_container.dart';

import '../../controllers/page/pagecontrol_cubit.dart';

class WeatherCard extends StatefulWidget {
  const WeatherCard({super.key});

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  @override
  void initState() {
    // TODO: implement initState

    context.read<WeatherControlCubit>().getWeather(null);

    super.initState();
  }

  void changeThemeColor(String condition, int isDay) {
    final lower = condition.toLowerCase();

    if (lower.contains('sunny') || lower.contains('clear')) {
      if (isDay == 1) {
        context.read<ThemeControlCubit>().changeColor(AppColors.sunny);
        context.read<PagecontrolCubit>().state.animateToPage(
          0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      } else {
        context.read<ThemeControlCubit>().changeColor(AppColors.stormy);
        context.read<PagecontrolCubit>().state.animateToPage(
          1,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    } else if (lower.contains('cloud')) {
      context.read<ThemeControlCubit>().changeColor(AppColors.cloudy);
      context.read<PagecontrolCubit>().state.animateToPage(
        2,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else if (lower.contains('rain') ||
        lower.contains('drizzle') ||
        lower.contains('shower')) {
      context.read<ThemeControlCubit>().changeColor(AppColors.rainy);
      context.read<PagecontrolCubit>().state.animateToPage(
        3,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else if (lower.contains('thunder') ||
        lower.contains('storm') ||
        lower.contains('lightning')) {
      context.read<ThemeControlCubit>().changeColor(AppColors.stormy);
      context.read<PagecontrolCubit>().state.animateToPage(
        4,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else if (lower.contains('snow') ||
        lower.contains('sleet') ||
        lower.contains('blizzard') ||
        lower.contains('ice')) {
      context.read<ThemeControlCubit>().changeColor(AppColors.snowy);
      context.read<PagecontrolCubit>().state.animateToPage(
        5,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else if (lower.contains('mist') ||
        lower.contains('fog') ||
        lower.contains('haze')) {
      context.read<ThemeControlCubit>().changeColor(AppColors.cloudy);
      context.read<PagecontrolCubit>().state.animateToPage(
        6,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      context.read<ThemeControlCubit>().changeColor(AppColors.sunny);
      context.read<PagecontrolCubit>().state.animateToPage(
        0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Color mainColor = Theme.of(context).primaryColor;
    return BlocConsumer<WeatherControlCubit, WeatherControlState>(
      listener: (context, state) {
        if (state is WeatherControlFailure) {
          print(state.error);
        } else if (state is WeatherControlLoading) {
          print('Loading');
        }
      },
      builder: (context, state) {
        if (state is WeatherControlSuccess) {
          WeatherModel weatherModel = state.weatherModel;
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            changeThemeColor(weatherModel.conditionText, weatherModel.isDay);
          });
          return SizedBox(
            width: double.infinity,
            child: Card(
              elevation: 10,
              shape: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1.2,
                  color: AppColors.textPrimary,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              color: mainColor.withOpacity(.7),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on, color: AppColors.textPrimary),
                        CustomText(
                          text: weatherModel.name + "," + weatherModel.country,
                          weight: FontWeight.w500,
                          size: 20,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          "https:" + weatherModel.conditionIcon,
                          width: 100,
                          height: 100,
                          fit: BoxFit.scaleDown,
                        ),
                        SizedBox(width: 50),
                        CustomText(
                          text: "${weatherModel.tempC} C",
                          weight: FontWeight.w700,
                          size: 30,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),

                    CustomText(
                      text: weatherModel.conditionText,
                      weight: FontWeight.w500,
                      size: 17,
                    ),
                    SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StetusContainer(
                          name: "Feels Like",
                          icon: Icons.thermostat,
                          disc: weatherModel.feelsLikeC.toString(),
                        ),

                        SizedBox(width: 30),
                        StetusContainer(
                          name: "Humidity",
                          icon: Icons.water_drop_rounded,
                          disc: "${weatherModel.humidity} %",
                        ),

                        SizedBox(width: 30),
                        StetusContainer(
                          name: "Wind",
                          icon: Icons.air,
                          disc: "${weatherModel.windKph} Km/h",
                        ),
                      ],
                    ),
                    SizedBox(height: 10),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: mainColor.withOpacity(.4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            StetusContainer(
                              name: "pressure",
                              icon: Icons.compress_outlined,
                              disc: "${weatherModel.pressureMb} mb",
                            ),
                            Container(
                              margin: EdgeInsetsGeometry.symmetric(
                                horizontal: 30,
                              ),
                              height: 40,
                              width: 2,
                              color: AppColors.textSecondary,
                            ),
                            StetusContainer(
                              name: "last Updated",
                              icon: Icons.update,
                              disc: "Now",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return SizedBox(
            width: double.infinity,
            child: Card(
              elevation: 10,
              shape: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1.2,
                  color: AppColors.textPrimary,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              color: mainColor.withOpacity(.7),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: CupertinoActivityIndicator(color: AppColors.textPrimary),
              ),
            ),
          );
        }
      },
    );
  }
}
