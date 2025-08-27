import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weather_app/controllers/theme/theme_control_cubit.dart';
import 'package:weather_app/controllers/weather/weather_control_cubit.dart';
import 'package:weather_app/helpers/theme/app_colors.dart';
import 'package:weather_app/helpers/wigets/custom_text.dart';
import 'package:weather_app/helpers/wigets/show_snack.dart';
import 'package:weather_app/models/weather/weather_model.dart';
import 'package:weather_app/views/widgets/shimmer_card.dart';
import 'package:weather_app/views/widgets/stetus_container.dart';

import '../../controllers/page/pagecontrol_cubit.dart';
import 'anim_list.dart';

class WeatherCard extends StatefulWidget {
  const WeatherCard({super.key});

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  @override
  void initState() {
    // TODO: implement initState

    getWeather();
    super.initState();
  }

  Future getWeather() async {
    await context.read<WeatherControlCubit>().getWeather(null);
    AnimList.opacity = 1;
    context.read<PagecontrolCubit>().refresh();
  }

  void changeThemeColor(String condition, int isDay) {
    final lower = condition.toLowerCase();

    if (lower.contains('sunny') || lower.contains('clear')) {
      if (isDay == 1) {
        context.read<ThemeControlCubit>().changeColor(AppColors.sunny);
        context.read<PagecontrolCubit>().animateToIndex(0);
      } else {
        context.read<ThemeControlCubit>().changeColor(AppColors.stormy);
        context.read<PagecontrolCubit>().animateToIndex(1);
      }
    } else if (lower.contains('cloud')) {
      context.read<ThemeControlCubit>().changeColor(AppColors.cloudy);
      context.read<PagecontrolCubit>().animateToIndex(2);
    } else if (lower.contains('rain') ||
        lower.contains('drizzle') ||
        lower.contains('shower')) {
      context.read<ThemeControlCubit>().changeColor(AppColors.rainy);
      context.read<PagecontrolCubit>().animateToIndex(3);
    } else if (lower.contains('thunder') ||
        lower.contains('storm') ||
        lower.contains('lightning')) {
      context.read<ThemeControlCubit>().changeColor(AppColors.stormy);
      context.read<PagecontrolCubit>().animateToIndex(4);
    } else if (lower.contains('snow') ||
        lower.contains('sleet') ||
        lower.contains('blizzard') ||
        lower.contains('ice')) {
      context.read<ThemeControlCubit>().changeColor(AppColors.snowy);
      context.read<PagecontrolCubit>().animateToIndex(5);
    } else if (lower.contains('mist') ||
        lower.contains('fog') ||
        lower.contains('haze')) {
      context.read<ThemeControlCubit>().changeColor(AppColors.cloudy);
      context.read<PagecontrolCubit>().animateToIndex(6);
    } else {
      // Default case
      context.read<ThemeControlCubit>().changeColor(AppColors.sunny);
      context.read<PagecontrolCubit>().animateToIndex(0);
    }
  }

  Stream<String> timeStream() {
    return Stream.periodic(const Duration(seconds: 1), (_) {
      final diff = DateTime.now().difference(
        context.read<WeatherControlCubit>().lastUpdate,
      );

      if (diff.inSeconds == 0) {
        return "Now";
      } else if (diff.inMinutes == 0) {
        return "${diff.inSeconds} Sec";
      } else if (diff.inHours == 0) {
        return "${diff.inMinutes} Min";
      } else {
        return " ${diff.inHours} Hr";
      }
    });
  }

  RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  Widget build(BuildContext context) {
    Color mainColor = Theme.of(context).primaryColor;
    return BlocConsumer<WeatherControlCubit, WeatherControlState>(
      listener: (context, state) {
        if (state is WeatherControlFailure) {
          ShowSnack.showSnack(context, state.error);
        } else if (state is WeatherControlLoading) {
        } else if (state is WeatherControlSuccess) {
          WeatherModel weatherModel = state.weatherModel;
          changeThemeColor(weatherModel.conditionText, weatherModel.isDay);
        }
      },
      builder: (context, state) {
        if (state is WeatherControlSuccess) {
          WeatherModel weatherModel = state.weatherModel;
          return SmartRefresher(
            enablePullDown: true,
            onRefresh: () {
              context.read<WeatherControlCubit>().getWeather(weatherModel.name);
            },
            header: ClassicHeader(
              refreshingIcon: CupertinoActivityIndicator(
                color: AppColors.textPrimary,
              ),
            ),
            physics: BouncingScrollPhysics(),
            controller: refreshController,
            child: SizedBox(
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
                            text:
                                weatherModel.name + "," + weatherModel.country,
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
                              StreamBuilder(
                                stream: timeStream(),
                                builder: (context, asyncSnapshot) {
                                  return StetusContainer(
                                    name: "last Updated",
                                    icon: Icons.update,
                                    disc: asyncSnapshot.data == null
                                        ? "Now"
                                        : asyncSnapshot.data!,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return SizedBox(width: double.infinity, child: ShimmerCard());
        }
      },
    );
  }
}
