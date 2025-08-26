import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/controllers/page/pagecontrol_cubit.dart';

class AnimList extends StatefulWidget {
  const AnimList({super.key});

  @override
  State<AnimList> createState() => _AnimListState();
}

class _AnimListState extends State<AnimList> {
  final List<Icon> weatherIcons = [
    Icon(Icons.wb_sunny, size: 120, color: Colors.orange), // Sunny / Clear
    Icon(
      Icons.nightlight_round,
      size: 120,
      color: Colors.indigo,
    ), // Night Clear
    Icon(Icons.cloud, size: 120, color: Colors.grey), // Cloudy
    Icon(Icons.umbrella, size: 120, color: Colors.blueAccent), // Rain / Shower
    Icon(Icons.bolt, size: 120, color: Colors.deepPurple), // Thunder / Storm
    Icon(Icons.ac_unit, size: 120, color: Colors.lightBlueAccent), // Snow / Ice
    Icon(Icons.blur_on, size: 120, color: Colors.blueGrey), // Mist / Fog / Haze
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PagecontrolCubit, PageController>(
      builder: (context, state) {
        PageController pageController = state;
        return PageView.builder(
          controller: pageController,
          itemCount: weatherIcons.length,
          itemBuilder: (context, index) {
            return AnimatedBuilder(
              animation: pageController,
              builder: (context, child) {
                double currPage = 0;

                if (pageController.position.hasContentDimensions) {
                  currPage =
                      pageController.page ??
                      pageController.initialPage.toDouble();
                }

                final diff = index - currPage;

                // خلي range بين 0.6 و 1.0 (فرق أوضح)
                final scale = (1 - (diff.abs() * 0.4)).clamp(0.6, 1.0);

                // الترانسليت زي ما هو يخليه يطلع من تحت
                final translate = Offset(0, diff.abs() * 60);

                return Center(
                  child: Transform.translate(
                    offset: translate,
                    child: Transform.scale(scale: scale, child: child),
                  ),
                );
              },
              child: weatherIcons[index],
            );
          },
        );
      },
    );
  }
}
