import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/views/widgets/stetus_container.dart';

import '../../helpers/theme/app_colors.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    Color mainColor = Theme.of(context).primaryColor;
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 10,
        shape: OutlineInputBorder(
          borderSide: BorderSide(width: 1.2, color: AppColors.textPrimary),
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
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.textPrimary,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    width: 100,
                    height: 20,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    child: CupertinoActivityIndicator(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(width: 50),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.textPrimary,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    width: 60,
                    height: 20,
                  ),
                ],
              ),
              SizedBox(height: 10),

              Container(
                decoration: BoxDecoration(
                  color: AppColors.textPrimary,
                  borderRadius: BorderRadius.circular(30),
                ),
                width: 50,
                height: 17,
              ),
              SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StetusContainer(
                    name: "Feels Like",
                    icon: Icons.thermostat,
                    disc: "----",
                  ),

                  SizedBox(width: 30),
                  StetusContainer(
                    name: "Humidity",
                    icon: Icons.water_drop_rounded,
                    disc: "--- %",
                  ),

                  SizedBox(width: 30),
                  StetusContainer(
                    name: "Wind",
                    icon: Icons.air,
                    disc: "--- Km/h",
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
                        disc: "--- mb",
                      ),
                      Container(
                        margin: EdgeInsetsGeometry.symmetric(horizontal: 30),
                        height: 40,
                        width: 2,
                        color: AppColors.textSecondary,
                      ),
                      StetusContainer(
                        name: "last Updated",
                        icon: Icons.update,
                        disc: "---",
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
  }
}
