import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/controllers/weather/weather_control_cubit.dart';
import 'package:weather_app/helpers/theme/app_colors.dart';

class SearchForm extends StatefulWidget {
  SearchForm({super.key});

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final TextEditingController searchCont = TextEditingController();

  final double borderWidth = 1.2;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TextField(
        expands: true,
        maxLines: null,
        controller: searchCont,
        decoration: InputDecoration(
          fillColor: Theme.of(context).primaryColor.withOpacity(.7),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(
              color: AppColors.textPrimary,
              width: borderWidth,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(
              color: AppColors.textPrimary,
              width: borderWidth,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(
              color: AppColors.textPrimary,
              width: borderWidth,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(
              color: AppColors.textPrimary,
              width: borderWidth,
            ),
          ),
          contentPadding: EdgeInsets.only(right: 20),
          prefixIcon: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 15),
            child: Icon(Icons.search_outlined, color: AppColors.textSecondary),
          ),
          prefixIconConstraints: BoxConstraints.tightFor(width: 50),
          hintText: "search for a city...",
          hintStyle: GoogleFonts.aBeeZee(
            color: AppColors.textSecondary,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          suffixIcon: BlocBuilder<WeatherControlCubit, WeatherControlState>(
            builder: (context, state) {
              return state is! WeatherControlLoading
                  ? GestureDetector(
                      onTap: () {
                        context.read<WeatherControlCubit>().getWeather(
                          searchCont.text.isEmpty
                              ? null
                              : searchCont.text.trim(),
                        );
                      },
                      child: Icon(Icons.send, color: AppColors.textSecondary),
                    )
                  : CupertinoActivityIndicator(color: AppColors.textPrimary);
            },
          ),
        ),
      ),
    );
  }
}
