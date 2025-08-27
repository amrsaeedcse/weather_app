import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weather_app/views/widgets/anim_list.dart';
import 'package:weather_app/views/widgets/search_form.dart';
import 'package:weather_app/views/widgets/weather_card.dart';

import '../../helpers/theme/app_colors.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 60),
                SearchForm(),
                SizedBox(height: 30),
                Flexible(child: WeatherCard()),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: MediaQuery.of(context).size.height / 2 - 300,
              child: SizedBox(height: 200, child: AnimList()),
            ),
          ],
        ),
      ),
    );
  }
}
