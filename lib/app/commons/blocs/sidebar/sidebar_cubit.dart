import 'package:eatagain/app/commons/infra/models/nav_item_model.dart';
import 'package:eatagain/app/core/orders/orders_routes.dart';
import 'package:eatagain/app/core/payment_methods/payment_methods_routes.dart';
import 'package:eatagain/app/core/restaurant_menu/constants/restaurant_menu_routes.dart';
import 'package:eatagain/app/core/restaurant_settings/constants/restaurant_settings_routes.dart';
import 'package:eatagain/app/core/working_days/working_days_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'sidebar_state.dart';

class SidebarCubit extends Cubit<SidebarState> {
  SidebarCubit() : super(SidebarState());

  void onNavigateTo(int page) {
    Modular.to.navigate(state.menus[page].root.complete);
    emit(state.copyWith(active: page));
  }
}
