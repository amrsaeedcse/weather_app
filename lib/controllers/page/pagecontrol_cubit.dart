import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

class PagecontrolCubit extends Cubit<PageController> {
  PagecontrolCubit() : super(PageController(viewportFraction: .5));
  void animateToIndex(int page) {
    print("dsds");
    state.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void refresh() {
    emit(state);
  }
}
