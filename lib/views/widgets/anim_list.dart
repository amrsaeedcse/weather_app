import 'package:animated_floating_widget/animated_floating_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/controllers/page/pagecontrol_cubit.dart';

class AnimList extends StatefulWidget {
  const AnimList({super.key});

  @override
  State<AnimList> createState() => _AnimListState();
  static double opacity = 0;
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
        return AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          opacity: AnimList.opacity,
          child: PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            controller: state,
            itemCount: weatherIcons.length,
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: state,
                builder: (context, child) {
                  double currPage = 0;

                  if (state.position.hasContentDimensions) {
                    currPage = state.page ?? state.initialPage.toDouble();
                  }

                  final diff = index - currPage;

                  final scale = (1 - (diff.abs() * 0.4)).clamp(0.6, 1.0);

                  final translate = Offset(0, diff.abs() * 60);

                  return Center(
                    child: Transform.translate(
                      offset: translate,
                      child: Transform.scale(
                        scale: scale,
                        child: diff == 0
                            ? FloatingWidget(
                                duration: Duration(milliseconds: 1500),
                                horizontalSpace: 40,
                                direction:
                                    FloatingDirection.topCenterToBottomCenter,
                                beginOffset: Offset(0, -.3),
                                endOffset: Offset(0, .3),
                                reverseDuration: Duration(milliseconds: 1500),
                                child: child!,
                              )
                            : child,
                      ),
                    ),
                  );
                },
                child: weatherIcons[index],
              );
            },
          ),
        );
      },
    );
  }
}
